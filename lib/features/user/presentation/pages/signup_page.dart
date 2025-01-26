
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone_practice/features/app/home/home_page.dart';
import 'package:whatsapp_clone_practice/features/controllers/login_page_controller.dart';
import 'package:whatsapp_clone_practice/features/user/presentation/pages/login_page.dart';
import 'package:whatsapp_clone_practice/features/widgets/validator.dart';
import '../../../app/global/widgets/profile_widget.dart';
import '../../../app/theme/style.dart';
import '../../../widgets/loginpage_widgets.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final controller = Get.put(LoginPageController());
final _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.05,
                    ),
                    Form(
                        key: _formkey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            // GestureDetector(
                            //   onTap:() => controller.selectimage(),
                            //   child: Container(
                            //     height: 100,
                            //     width: 100,
                            //     child: ClipRRect(
                            //       borderRadius: BorderRadius.circular(25),
                            //       child: Profilewidget(image: controller.image==null?null:controller.image!.value),
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(height: 10,),
                            TextFormField(
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "First Name is required";
                                }else{
                                  return null;
                                }
                              },
                              controller: controller.usernameController,
                              decoration: const InputDecoration(
                                  labelText: "First name"),
                            ),
                            const SizedBox(height: 10,),
                            TextFormField(
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Last Name is required";
                                }else{
                                  return null;
                                }
                              },
                              controller: controller.userlastnameController,
                              decoration: const InputDecoration(
                                  labelText: "Last name"),
                            ),
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: controller.signupemail,
                              validator: (value) => emailvalidator(value: value!),
                              decoration: InputDecoration(
                                labelText: 'Email',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(
                                  ()=> TextFormField(
                                controller: controller.signuppassword,
                                validator: (value) =>passwordvalidator(value: value!),
                                      decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.signupshowpass.value=!controller.signupshowpass.value;
                                      },
                                      icon:
                                      Icon(controller.signupshowpass.value
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                    labelText: 'Password'),
                                obscureText: !controller.signupshowpass.value,
                              ),
                            ),
                            SizedBox(height: 10,),
                        Obx(
                              ()=> TextFormField(
                            controller: controller.signuprepassword,
                            validator: (value) =>reenterpasswordvalidator(value: value!, match: controller.signuppassword.text.trim().toString()),
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.signupshowrepass.value=!controller.signupshowrepass.value;

                                  },
                                  icon:
                                  Icon(controller.signupshowrepass.value
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                labelText: 'ReEnter Password'),
                            obscureText: !controller.signupshowrepass.value,
                          ),
                        ),
                            SizedBox(height: 10,),
                            Obx(
                                  () => ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 2),
                                onTap: openFilteredCountryPickerDialog,
                                title: buildDialogItem(
                                    LoginPageController.selectedfiltereddialogcountry.value),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1.50,
                                        color: Colors.white10,
                                      ),
                                    ),
                                  ),
                                  width: 80,
                                  height: 42,
                                  alignment: Alignment.center,
                                  child: Obx(() => Text(
                                      LoginPageController.selectedfiltereddialogcountry
                                          .value.phoneCode)),
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    margin: const EdgeInsets.only(top: 1.5),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom:
                                            BorderSide(color: Colors.white10, width: 1.5))),
                                    child: TextFormField(
                                      controller: controller.phonenumber,
                                      keyboardType: TextInputType.phone,
                                      decoration: const InputDecoration(
                                          hintText: "Phone Number",
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(child: GestureDetector(
                                    onTap: () async{
                                    final crendial=await controller.signInWithGoogle();
                                    if(crendial!=null){
                                      print("user data:${crendial.user}");
                                      print("user data:${crendial.user!.displayName}");
                                      print("user data:${crendial.additionalUserInfo}");
                                      Get.offAll(HomePage());
                                    }
                                    },
                                    child: Text("Continue with google?",style: TextStyle(color: Colors.blue),))),
                                // Spacer(),
                                Expanded(child: Text("Already have an account? ")),
                                GestureDetector(
                                    onTap: () {
                                      Get.to(LoginPage());
                                    },
                                    child: Text("Login",style: TextStyle(color: Colors.blue),)),
                              ],
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                String phoneNumber =
                    "+"+LoginPageController.selectedfiltereddialogcountry
                        .value.phoneCode +
                        controller.phonenumber.text.trim();
               if(_formkey.currentState!.validate()&&controller.phonenumber.text.trim().isNotEmpty&&controller.issendingotp.value==false){
                 controller.signUpWithEmail();
               }
              print(phoneNumber);
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
                  child: Obx(() => controller.issendingotp.value? Container(
                      padding: EdgeInsets.all(5),
                      child: const CircularProgressIndicator()): const Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
