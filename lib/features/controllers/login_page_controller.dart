import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone_practice/features/app/home/home_page.dart';
import '../app/const/app_const.dart';

class LoginPageController extends GetxController{
  final firestore = FirebaseFirestore.instance;

  var issendingotp=false.obs;
  var isverifyingotp=false.obs;
  var showpassword=false.obs;

  var signupshowpass=false.obs;
  var signupshowrepass=false.obs;
  // otp and enter number
  final TextEditingController loginemail = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();
  final TextEditingController loginpassword = TextEditingController();
  final TextEditingController signupemail = TextEditingController();
  final TextEditingController signuppassword = TextEditingController();
  final TextEditingController signuprepassword = TextEditingController();
  static Rx<Country> selectedfiltereddialogcountry = CountryPickerUtils.getCountryByPhoneCode("92").obs;
  Rx<String> countrycode = selectedfiltereddialogcountry.value.phoneCode.obs;
  resetcontroller(){
    loginemail.text="";
    loginpassword.text="";
    phonenumber.text="";
    signupemail.text="";
    signuppassword.text="";
    signuprepassword.text="";
    signuprepassword.text="";
    usernameController.text="";
    userlastnameController.text="";
  }
  // profile page
  final TextEditingController usernameController=TextEditingController();
  final TextEditingController userlastnameController=TextEditingController();
  Rx<XFile>? image;
  Future selectimage()async{
    try{
      XFile? file =await ImagePicker().pickImage(source: ImageSource.gallery);
        if(file!=null){
          image!.value=file;
        }else{
          print("photo is not selected");
        }
    }catch(e){
      toast(message: "some error occurred $e");
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUpWithEmail() async {
    issendingotp.value=true;
    try {
      print(signupemail);
      print(signuppassword);
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: signupemail.text.trim(),
        password: signuppassword.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
         Get.snackbar('Sign-up successful!', "enjoy to chat with your friend.");
         storeuserdata();
         issendingotp.value=false;
         Get.offAll(HomePage());
      }
         issendingotp.value=false;
    } catch (e) {
         issendingotp.value=false;
        print("error: $e");
        Get.snackbar('Error!', "'Unexpected error: $e'");

    }


  }
    Future<UserCredential?> loginmethod() async {

      UserCredential? userCredential;
      isverifyingotp.value=true;
      try {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: loginemail.text.trim(), password: loginpassword.text.trim());
            if(userCredential.user!=null){
              isverifyingotp.value=false;
              Get.snackbar("Login Successfully!", "Enjoy to chat with your friend and family.");
              resetcontroller();
              Get.offAll(HomePage());
            }
        isverifyingotp.value=false;
      } on FirebaseAuthException catch (e) {
        isverifyingotp.value=false;
       Get.snackbar("Error in login", e.message.toString());
      }
      return userCredential;
    }

  storeuserdata({bool isgoogle=false,User? user}) async {
    DocumentReference store = await firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    store.set({
      "first_name": isgoogle?user!.displayName:usernameController.text.trim(),
      "about":"Hey i'm using whatsapp.",
      "created_at":Timestamp.now(),
      "is_online":false,
      "last_name": isgoogle?user!.displayName:usernameController.text.trim(),
      "last_active":Timestamp.now(),
      "push_token":"",
      "email": isgoogle?user!.email:signupemail.text.trim(),
      "password": isgoogle?"":signuppassword.text.trim(),
      "imgurl": isgoogle?user!.photoURL:"",
      "id": FirebaseAuth.instance.currentUser!.uid,
      "phone_number":isgoogle?user!.phoneNumber:phonenumber.text.trim()
    });
    CollectionReference contactsCollection = store.collection("contacts");
    resetcontroller();
  }


  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Begin interactive sign-in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // User cancels Google Sign-In popup screen
      if (gUser == null) {
        Get.snackbar("AlertBox", "Google Sign-In was canceled by the user.");
        return null;
      }

      // Obtain authentication details from the user
      final GoogleSignInAuthentication gAuth = await gUser.authentication;


      print("Access Token: ${gAuth.accessToken}");
      print("ID Token: ${gAuth.idToken}");
      // Check if authentication details are valid
      if (gAuth.accessToken == null || gAuth.idToken == null) {
        Get.snackbar("AlertBox", "Google Sign-In authentication details are invalid.");
        return null;
      }

      // Create a new credential for the user
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      if(await userexist()){

      }else{
        storeuserdata(isgoogle: true,user: userCredential.user);
      }
      Get.snackbar("Alert Box", "Google Sign-In successful: ${userCredential.user?.displayName}");
      return userCredential;
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Alert Box", "FirebaseAuthException: ${e.message}");
      return null;
    } catch (e) {
      // Handle other errors
      Get.snackbar("Alert Box", "An error occurred during Google Sign-In: $e");
      return null;
    }
  }
  userexist()async{
    return( await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get()).exists;
  }
}