import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone_practice/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_practice/features/app/home/add_contact.dart';
import 'package:whatsapp_clone_practice/features/app/theme/style.dart';
import 'package:whatsapp_clone_practice/features/chat/presentation/pages/single_chat_page.dart';
import 'package:whatsapp_clone_practice/features/controllers/chat_controller.dart';

class Contactspage extends StatelessWidget {
  Contactspage({super.key});
  final controller=Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Contact"),
      ),
    body: Column(
      children: [
        InkWell(
          onTap: () {

          },
          child: customrow(icon: Icons.group_add,title: "New Group"),
        ),
        const SizedBox(height: 10,),
       InkWell(
         onTap: () {
            Get.to(AddContact());
         },
         child:  customrow(icon: Icons.person_add_alt_1_rounded,title: "New Contact"),
       ),
        SizedBox(height: 10,),
        const Align(
            alignment: Alignment.bottomLeft,
            child: Text("     Contacts on Whatsapp",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
        StreamBuilder<QuerySnapshot>(
          stream: controller.getContactsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Expanded(child: const Center(child: CircularProgressIndicator()));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Expanded(child: const Center(child: Text("No contacts found.")));
            }

            // Get the contacts
            var contacts = snapshot.data!.docs;

            return  Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:  List.generate(contacts.length, (index) => GestureDetector(
                    onTap: () async{
                      controller.chatid = await controller.getOrCreateChatId(
                          userId1: controller.currentUser!.uid, userId2: contacts[index]["id"].toString(), user2name: "${contacts[index]["first_name"]} ${contacts[index]["last_name"]}");
                      Navigator.pop(context);
                      Get.to(SingleChatPage());
                    },
                    child: ListTile(
                    leading: SizedBox(
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Profilewidget(),
                      ),
                    ),
                    title: Text("${contacts[index]["first_name"]} ${contacts[index]["last_name"]}"),
                    subtitle: const Text("Hey There! i'm using WhatsApp."),
                                    ),
                  ),),
                ),
              ),
            );
          },
        ),
      ],
    ),
    );
  }
  customrow({required IconData icon,required title}){
    return Row(
      children: [
        const SizedBox(width: 10,),
        CircleAvatar(radius: 29,child: Icon(icon,size: 25,),backgroundColor: tabColor,),
        const SizedBox(width: 10,),
        Text(title)
      ],
    );
  }
}

