import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone_practice/features/chat/presentation/pages/single_chat_page.dart';
import '../app/const/firebase_collection_const.dart';

class ChatController extends GetxController {

  String chatid = "";
  var username="".obs;
  var otheruserid="".obs;
  markAsSeen() async {
    print("other"+otheruserid.value);
    // print(chatid);
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(FirebaseCollectionConst.chatscollection)
          .doc(chatid)
          .collection('messages')
          .where("senderId", isEqualTo: otheruserid.value)
          .where("status", isNotEqualTo:"seen")
          .get();
      print("size"+querySnapshot.size.toString());
      if (querySnapshot.docs.isNotEmpty) {
        final batch = FirebaseFirestore.instance.batch();

        for (final doc in querySnapshot.docs) {
          final docRef = doc.reference;
          batch.update(docRef, {'status': 'seen'});
        }

        await batch.commit();
        print('Successfully updated ${querySnapshot.size} messages to viewed');
      }
    } catch (e) {
      print('Error updating message status: $e');
      // Consider adding error handling/retry logic here
    }
  }
  static Rx<Country> selectedfiltereddialogcountry =
      CountryPickerUtils.getCountryByPhoneCode("92").obs;
  final currentUser = FirebaseAuth.instance.currentUser;

  final phonenumber = TextEditingController();
  final addfirstname = TextEditingController();
  final addlastname = TextEditingController();
  final addemail = TextEditingController();
  var addingcontact = false.obs;
  TextEditingController textmessagecontroller = TextEditingController();
  var isdisplaysendicon = false.obs;
  var isdisplaywindowattach = false.obs;
  final firestore = FirebaseFirestore.instance;

  resetcontroller() {
    phonenumber.text = "";
    addfirstname.text = "";
    addlastname.text = "";
    addemail.text = "";
  }

  Stream<QuerySnapshot> getContactsStream() {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Return a stream of all documents in the 'contacts' subcollection
    return firestore
        .collection("users")
        .doc(userId)
        .collection("contacts")
        .snapshots();
  }
  Future<QuerySnapshot> checkContactById(String userId) async {
     return await firestore
         .collection("users")
         .doc(FirebaseAuth.instance.currentUser!.uid)
         .collection("contacts")
          .where("id",isEqualTo: userId)
         .get();
  }

  Future<void> addContact() async {
    addingcontact.value = true;
    try {
      final firestore = FirebaseFirestore.instance;

      QuerySnapshot userSnapshot = await firestore
          .collection("users")
          .where("email", isEqualTo: addemail.text.trim())
          .get();

      if (userSnapshot.docs.isEmpty) {
        Get.snackbar(
          "User Not Found",
          "The user with email ${addemail.text.trim()} does not exist.",
          snackPosition: SnackPosition.BOTTOM,
        );
        addingcontact.value = false;
        return;
      }

      QuerySnapshot response = await firestore
          .collection("users")
          .doc(currentUser!.uid)
          .collection("contacts")
          .where("email", isEqualTo: addemail.text.trim())
          .get();
      if (response.docs.isNotEmpty) {
        Get.snackbar(
          "Alert",
          "The user with email ${addemail.text.trim()} Already in your contact.",
          snackPosition: SnackPosition.BOTTOM,
        );
        addingcontact.value = false;
        return;
      }
      final userDoc = userSnapshot.docs.first;

      DocumentReference contactRef = firestore
          .collection("users")
          .doc(currentUser!.uid)
          .collection("contacts")
          .doc(userDoc["id"]);

      await contactRef.set({
        "email": addemail.text.trim(),
        "first_name": addfirstname.text.trim(),
        "last_name": addlastname.text.trim(),
        "id": userDoc["id"],
        "phone_number": userDoc["phone_number"],
        "imgurl": userDoc["imgurl"],
      });

      // Notify the user that the contact has been added
      Get.snackbar(
        "Contact Added",
        "The user with email ${addemail.text} has been added to your contacts.",
        snackPosition: SnackPosition.BOTTOM,
      );
      chatid = await getOrCreateChatId(
          userId1: currentUser!.uid, userId2: userDoc["id"],user2name:"${userDoc["first_name"]} ${userDoc["last_name"]}");
      addingcontact.value = false;
      resetcontroller();
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      Navigator.push(
          Get.context!,
          MaterialPageRoute(
            builder: (context) => SingleChatPage(),
          ));
    } catch (e) {
      addingcontact.value = false;
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> sendMessage() async {
    final messageRef = FirebaseFirestore.instance
        .collection(FirebaseCollectionConst.chatscollection)
        .doc(chatid)
        .collection('messages');

    var senttext=textmessagecontroller.text.trim();
    textmessagecontroller.text = "";
    // Add a new message
    await messageRef.add({
      'senderId': currentUser!.uid,
      'text': senttext,
      'timestamp': FieldValue.serverTimestamp(),
      'status': 'send', // Status can be 'sent', 'delivered', or 'seen'
      'type': 'text', // Can be 'text', 'image', etc.
    });
    // Update the chat document with the last message
    await FirebaseFirestore.instance
        .collection(FirebaseCollectionConst.chatscollection)
        .doc(chatid)
        .update({
      'lastMessage': senttext,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  getAllUserMessages() {
    return FirebaseFirestore.instance
        .collection(FirebaseCollectionConst.chatscollection)
        .doc(chatid)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // get all chats and group in which current user present
  getall() {
    return firestore
        .collection(FirebaseCollectionConst.chatscollection)
        .where("participants",
            arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  // create and get the chat id
  Future<String> getOrCreateChatId(
      {required String userId1,
      required String userId2,isgroup=false,required user2name}) async {
    final chatRef = FirebaseFirestore.instance.collection('chats');
    final query = await chatRef
        .where('participants', arrayContains: [userId1, userId2]).get();
    // final r = await FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .get();
    if (query.docs.isEmpty) {
      final currentuser=await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
      final doc = await chatRef.add({
        'isGroup': isgroup,
        'participants': [userId1, userId2],
        'lastMessage': '',
        'timestamp': FieldValue.serverTimestamp(),
        'names':{
          userId1:"${currentuser["first_name"]} ${currentuser["last_name"]}",
          userId2:user2name
        }
      });
      return doc.id;
    } else {
      return query.docs.first.id;
    }
  }
}
