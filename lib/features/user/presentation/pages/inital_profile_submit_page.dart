// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:whatsapp_clone_practice/features/app/global/widgets/profile_widget.dart';
// import 'package:whatsapp_clone_practice/features/controllers/login_page_controller.dart';
//
// import '../../../app/home/home_page.dart';
// import '../../../app/theme/style.dart';
//
// class InitalProfileSubmitPage extends StatelessWidget {
//   InitalProfileSubmitPage({super.key, this.email, this.password, this.phone});
//
//   final controller=Get.find<LoginPageController>();
//   final email;
//   final password;
//   final phone;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
//         child: Column(
//           children: [
//             Expanded(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 30,),
//                   const Center(child: Text("Profile Info", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: tabColor),),),
//                   const SizedBox(height: 10,),
//                   const Text("Please provide your name and an optional profile photo", textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),
//                   const SizedBox(height: 30,),
//
//                   const SizedBox(height: 20,),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: (){
//                 Get.to(HomePage());
//               },
//               child: Container(
//                 width: 150,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: tabColor,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: const Center(
//                   child: Text("Next", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
