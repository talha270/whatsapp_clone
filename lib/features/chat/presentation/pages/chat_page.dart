import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone_practice/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_practice/features/app/theme/style.dart';
import 'package:whatsapp_clone_practice/features/chat/presentation/pages/single_chat_page.dart';
import 'package:whatsapp_clone_practice/features/controllers/chat_controller.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final searchcontroller=TextEditingController();
  final controller=Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // SizedBox(
                  //     height: 30,
                  //     width: 30,
                  //     child: Image.asset("assets/circle.gif")),
                  SizedBox(width: 10,),
                  SizedBox(
                    height: 50,
                    width: Get.width-80,
                    child: TextField(
                      controller: searchcontroller,
                      decoration: InputDecoration(
                          hintText: "Ask Meta AI or Search",
                          hintStyle: TextStyle(color: greyColor),
                          border: InputBorder.none
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: controller.getall(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(child: const Center(child: CircularProgressIndicator()));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Expanded(child: const Center(child: Text("No Messages found.")));
              }

              // Get the contacts
              var contacts = snapshot.data!.docs;

              return Expanded(
                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    var contact = contacts[index];
                    return GestureDetector(
                      onTap: () {
                        controller.chatid=contact.id;
                        print(FirebaseAuth.instance.currentUser!.displayName);
                        Get.to(SingleChatPage());
                      },
                      child: ListTile(
                        leading: SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Profilewidget(),
                          ),
                        ),
                        title:  Text("fadjlfsa v"),
                        subtitle:  Text(contact["lastMessage"],maxLines: 1,overflow: TextOverflow.ellipsis,),
                        trailing: Text(DateFormat.jm().format(contact["timestamp"]==null?DateTime.now():contact["timestamp"].toDate()), style: const TextStyle(color: greyColor, fontSize: 13)),
                      ),
                    );
                  },
                ),
              );
            },
          ),

        ],
      )
    );
  }
}

