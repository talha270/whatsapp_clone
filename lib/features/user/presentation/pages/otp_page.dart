// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:whatsapp_clone_practice/features/controllers/login_page_controller.dart';
// import 'package:whatsapp_clone_practice/features/user/presentation/pages/inital_profile_submit_page.dart';
//
// import '../../../app/theme/style.dart';
// import '../../../widgets/pincodewidget.dart';
//
// class OtpPage extends StatelessWidget {
//
//   OtpPage({super.key, required this.user});
//
//   final TextEditingController _otpController = TextEditingController();
//   final controller=Get.find<LoginPageController>();
//   final User user;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
//         child: Column(
//           children: [
//             Expanded(
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   const Center(
//                     child: Text(
//                       "Verify your OTP",
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: tabColor),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const Text(
//                     "Enter the OTP sent to your phone to complete the verification process.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 15),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   pincodewidget(controller: _otpController),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () async {
//                if(user.emailVerified){
//                  Get.offAll(InitalProfileSubmitPage());
//                };
//               },
//               child: Container(
//                 margin: const EdgeInsets.only(bottom: 20),
//                 width: 120,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: tabColor,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Center(
//                   child:
//                       Obx(() => controller.isverifyingotp.value?Container(
//                           padding: EdgeInsets.all(5),
//                           child: CircularProgressIndicator()):  Text(
//                         "Verify",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500),
//                       ),)
//
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
