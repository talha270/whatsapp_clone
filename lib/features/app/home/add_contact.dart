import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone_practice/features/app/theme/style.dart';
import 'package:whatsapp_clone_practice/features/controllers/chat_controller.dart';
import 'package:whatsapp_clone_practice/features/widgets/custom_text.dart';
import 'package:whatsapp_clone_practice/features/widgets/validator.dart';

class AddContact extends StatelessWidget {
  AddContact({super.key});
  final controller=Get.find<ChatController>();
  final _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Contact"),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          children: [
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formkey,
                child: SingleChildScrollView(child: Column(
              children: [
            Row(
            children: [
            Icon(Icons.person,color: greyColor,),
              SizedBox(width: 10,),
              Expanded(
                child: TextFormField(
                  controller: controller.addfirstname,
                  validator: (value) => simplevalidator(value: value!),
                  decoration: InputDecoration(
                      labelText: "First Name"
                  ),
                ),
              )
              ],
            ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    // Icon(Icons.person,color: greyColor,),
                    SizedBox(width: 35,),
                    Expanded(
                      child: TextFormField(
                        controller: controller.addlastname,
                        validator: (value) => simplevalidator(value: value!),
                        decoration: InputDecoration(
                            labelText: "Last Name"
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.email,color: greyColor,),
                    SizedBox(width: 10,),
                    Expanded(
                      child: TextFormField(
                        controller: controller.addemail,
                        validator: (value) => emailvalidator(value: value!),
                        decoration: InputDecoration(
                            labelText: "Enter email"
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.phone,color: greyColor,),
                    SizedBox(width: 10,),
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
                              ChatController.selectedfiltereddialogcountry
                                  .value.phoneCode)),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Container(
                          width: Get.width*0.55,
                          height: 40,
                          margin: const EdgeInsets.only(top: 1.5),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom:
                                  BorderSide(color: Colors.white10, width: 1.5))),
                          child: TextFormField(
                            validator: (value) => simplevalidator(value: value!),
                            controller: controller.phonenumber,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                hintText: "Phone Number",
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                  ],
            ))),
                Spacer(),
            Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height:50,
                  width: Get.width*0.5,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tabColor
                      ),
                      onPressed: () {
                        if(_formkey.currentState!.validate()){
                          controller.addContact();
                        }
                  }, child: Obx(() => controller.addingcontact.value?CircularProgressIndicator():customtext(text: "Save",wiegth: FontWeight.bold,size: 18,color: Colors.white)),)),
                )
          ],
        ),
      ),
    );
  }

}
