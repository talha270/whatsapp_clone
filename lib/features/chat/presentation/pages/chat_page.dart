import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone_practice/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_practice/features/app/theme/style.dart';
import 'package:whatsapp_clone_practice/features/chat/presentation/pages/single_chat_page.dart';
import 'package:whatsapp_clone_practice/features/controllers/chat_controller.dart';

import '../../../app/const/firebase_collection_const.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final searchcontroller=TextEditingController();
  final controller=Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // SizedBox(
                  //     height: 30,
                  //     width: 30,
                  //     child: Image.asset("assets/circle.gif")),
                  SizedBox(width: 10,),
                  SizedBox(
                    height: 50,
                    width: Get.width-80,
                    child: TextField(
                      controller: searchcontroller,
                      decoration: InputDecoration(
                          hintText: "Ask Meta AI or Search",
                          hintStyle: TextStyle(color: greyColor),
                          border: InputBorder.none
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: controller.getall(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(child: const Center(child: CircularProgressIndicator()));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Expanded(child: const Center(child: Text("No Messages found.")));
              }

              // Get the contacts
              var contacts = snapshot.data!.docs;

              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    var contact = contacts[index];

                    return FutureBuilder<QuerySnapshot>(
                      future: controller.checkContactById(
                        contact["participants"][0] == FirebaseAuth.instance.currentUser!.uid
                            ? contact["participants"][1]
                            : contact["participants"][0],
                      ),
                      builder: (context, secondsnapshot) {
                        if (secondsnapshot.connectionState == ConnectionState.waiting) {
                          return const SizedBox();
                        }

                        if (!secondsnapshot.hasData || secondsnapshot.data!.docs.isEmpty) {
                          // Handle the case where the document doesn't exist
                          return GestureDetector(
                            onTap: () {
                              controller.otheruserid.value = contact["participants"][0] == FirebaseAuth.instance.currentUser!.uid
                                  ? contact["participants"][1]
                                  : contact["participants"][0];

                              controller.chatid = contact.id;
                              controller.username.value= "Unknown User";
                              // print(FirebaseAuth.instance.currentUser!.displayName);
                              Get.to(SingleChatPage());
                            },
                            child: ListTile(
                              leading: SizedBox(
                                width: 50,
                                height: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Profilewidget(),
                                ),
                              ),
                              title: Text("Unknown User"),
                              subtitle: Text(contact["lastMessage"], maxLines: 1, overflow: TextOverflow.ellipsis),
                              trailing:
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    DateFormat.jm().format(contact["timestamp"] == null ? DateTime.now() : contact["timestamp"].toDate()),
                                    style: const TextStyle(color: greyColor, fontSize: 13),
                                  ),
                                  SizedBox(width: 10,),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: countunseen(contact.id),
                                    builder: (context, countersnapshot) {
                                      if (countersnapshot.connectionState == ConnectionState.waiting) {
                                        return SizedBox.shrink();
                                      }

                                      if (countersnapshot.data!.docs.length==0||!countersnapshot.hasData || countersnapshot.data == null) {
                                        return SizedBox.shrink();
                                      }

                                      return Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                          color: tabColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            countersnapshot.data!.docs.length.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        }

                        final data = secondsnapshot.data!.docs.first;
                        // as Map<String, dynamic>?;

                        return GestureDetector(
                          onTap: () {
                            controller.otheruserid.value = contact["participants"][0] == FirebaseAuth.instance.currentUser!.uid
                                ? contact["participants"][1]
                                : contact["participants"][0];
                            controller.chatid = contact.id;
                            controller.username.value = "${data["first_name"]} ${data["last_name"]}";
                            // print(FirebaseAuth.instance.currentUser!.displayName);
                            Get.to(SingleChatPage());
                          },
                          child: ListTile(
                            leading: SizedBox(
                              width: 50,
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Profilewidget(imageurl: data["imgurl"]),
                              ),
                            ),
                            title: Text("${data["first_name"]} ${data["last_name"]}"),
                            subtitle: Text(contact["lastMessage"], maxLines: 1, overflow: TextOverflow.ellipsis),
                            trailing:
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  DateFormat.jm().format(contact["timestamp"] == null ? DateTime.now() : contact["timestamp"].toDate()),
                                  style: const TextStyle(color: greyColor, fontSize: 13),
                                ),
                                SizedBox(width: 10,),
                                StreamBuilder<QuerySnapshot>(
                                  stream: countunseen(contact.id),
                                  builder: (context, countersnapshot) {
                                    if (countersnapshot.connectionState == ConnectionState.waiting) {
                                      return SizedBox.shrink();
                                    }

                                    if (countersnapshot.data!.docs.length==0||!countersnapshot.hasData || countersnapshot.data == null) {
                                      // print("null");
                                      // print("0"+(countersnapshot.data!.docs.length==0).toString());
                                      // print(!countersnapshot.hasData);
                                      // print( countersnapshot.data == null);

                                      return SizedBox.shrink();
                                    }

                                    return Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        color: tabColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          countersnapshot.data!.docs.length.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );


            },
          ),

        ],
      )
    );
  }
  countunseen(chatid){
    // print(chatid);
    return FirebaseFirestore.instance
        .collection(FirebaseCollectionConst.chatscollection)
        .doc(chatid)
        .collection('messages')
        // .orderBy('timestamp', descending: false)
        .where("senderId",isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("status",isEqualTo: "send")
        .snapshots();
  }

}

