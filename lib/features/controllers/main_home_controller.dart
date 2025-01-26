import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
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
  @override
  void onInit() {
    getdata();
    super.onInit();
  }
  getdata()async{
    var data=await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    print("data: "+jsonEncode(data.data()));
  }
  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
