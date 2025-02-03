import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone_practice/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_practice/features/controllers/login_page_controller.dart';
import 'package:whatsapp_clone_practice/features/user/presentation/pages/signup_page.dart';

import '../../../app/home/home_page.dart';
import '../../../app/theme/style.dart';

class InitalProfileSubmitPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          children: [
            // Spacer(),
            const SizedBox(height: 30,),
            Expanded(child: Image.asset("assets/bg_image.png",)),
            const SizedBox(height: 30,),
             Text("Add an account", textAlign: TextAlign.center,style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w400),),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(text: TextSpan(
                  style: TextStyle(fontSize: 15, color: Colors.white70), // Default text style
                  children:[
                    TextSpan(text: "Read our "),
                    TextSpan(
                      text: "privacy policy",
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold), // Highlighted text
                    ),
                    TextSpan(text: ". Tap "),
                    TextSpan(
                      text: "\"Agree and continue\"",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                ]
              )),
            ),
            RichText(text: TextSpan(
              children: [
                TextSpan(text: " to accept the "),
                TextSpan(
                  text: "Terms of Service.",
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ]
            )),
            const SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                Get.to(SignupPage());
              },
              child: Container(
                width: Get.width-50,
                height: 50,
                decoration: BoxDecoration(
                  color: tabColor,
                  borderRadius: BorderRadius.circular(70),
                ),
                child: const Center(
                  child: Text("Agree and continue", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),),
                ),
              ),
            ),
            // Spacer(),

          ],

        ),
      ),
    );
  }
}

