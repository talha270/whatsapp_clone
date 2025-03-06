import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  // Reactive variable for selected index
  var selectedIndex = 0.obs;
  
  // PageController for PageView
  final PageController pageController = PageController();

  void onPageChanged(int index) {
    selectedIndex.value = index;
  }

  void onBottomNavTap(int index) {
    selectedIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 4),
      curve: Curves.easeIn,
    );
  }
  setonline(){
    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set({"is_online":true},SetOptions(merge: true));

  }
  @override
  void onInit() {
    super.onInit();
    setonline();
    getdata();
    WidgetsBinding.instance.addObserver(this);
  }
  Stream<DocumentSnapshot<Map<String, dynamic>>> getdata() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getotheruserdata(userid) {
    print("other"+userid);
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userid)
        .snapshots();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive||state==AppLifecycleState.detached) {
      // App is going into the background
      onAppClose();
    }
    if(state==AppLifecycleState.resumed){
      setonline();
    }
  }


  Future<void> onAppClose() async {
    // Your function to execute before the app goes into the background
    print("App is closing or going into the background...");

    // Update Firestore
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .set({"is_online": false}, SetOptions(merge: true));
    }
  }
  @override
  void onClose(){
    pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    onAppClose();
    print("close closing");
    super.onClose();
  }
}
