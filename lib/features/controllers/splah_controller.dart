import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatsapp_clone_practice/features/app/home/home_page.dart';
import 'package:whatsapp_clone_practice/features/user/presentation/pages/inital_profile_submit_page.dart';
import 'package:whatsapp_clone_practice/features/user/presentation/pages/signup_page.dart';

class Splashcontroller extends GetxController {

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), checkInitialSession);
  }

  void checkInitialSession() {

    FirebaseAuth.instance.authStateChanges().listen(
          (user) {
        if (user == null) {
          Get.offAll(InitalProfileSubmitPage());
        } else {
          Get.offAll(HomePage());
        }
      },
    );
  }

}
