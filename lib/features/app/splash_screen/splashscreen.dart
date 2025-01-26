import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone_practice/features/controllers/splah_controller.dart';

import '../theme/style.dart';


class Splashscreen extends StatelessWidget{

  final controller=Get.put(Splashcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Image.asset("assets/whats_app_logo.png", color: Colors.white, width: 100, height: 100,),
          Column(
            children: [
              Text("From", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: greyColor.withOpacity(.6)),),
              const SizedBox(
                height: 10,
              ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Image.asset("assets/meta.png", color: Colors.white, width: 20, height: 20,),
                 const SizedBox(width: 5,),
                 const Text("Meta", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),),
               ],
             ),
              const SizedBox(
                height: 30,
              ),
            ],
          )
        ],
      ),
    );
  }
}