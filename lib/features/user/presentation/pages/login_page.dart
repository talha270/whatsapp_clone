import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone_practice/features/controllers/login_page_controller.dart';
import '../../../app/theme/style.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final controller = Get.put(LoginPageController());
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.05,
                      ),
                      Form(
                         key: _formkey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                        children: [
                          TextFormField(
                            controller: controller.loginemail,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              } else if (!RegExp(r'^[\w-]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
                                return 'Enter a valid email';
                              }else if(!value.contains("@")){
                                return "Enter a valid email";
                              }else{
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            ()=> TextFormField(
                              controller: controller.loginpassword,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Password is required";
                                }else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.showpassword.value=!controller.showpassword.value;
                                      },
                                      icon:
                                      Icon(controller.showpassword.value
                                          ? Icons.visibility
                                            : Icons.visibility_off),
                                      ),
                                  labelText: 'Password'),
                              obscureText: !controller.showpassword.value,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {

                  if(_formkey.currentState!.validate()&&controller.isverifyingotp.value==false){
                      controller.loginmethod();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: tabColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                      child: Obx(
                    () => controller.isverifyingotp.value
                        ? Container(
                            padding: EdgeInsets.all(5),
                            child: const CircularProgressIndicator())
                        : const Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
