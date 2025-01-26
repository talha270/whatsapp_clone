import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone_practice/features/app/theme/style.dart';
import 'package:whatsapp_clone_practice/features/chat/presentation/widgets/message_layout.dart';
import 'package:whatsapp_clone_practice/features/controllers/chat_controller.dart';

import '../widgets/attachwindowitem.dart';

class SingleChatPage extends StatelessWidget {
  SingleChatPage({super.key});
  final controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('UserName'),
              Text(
                "Online",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
              )
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.videocam_rounded,
                size: 25,
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            const Icon(
              Icons.call,
              size: 22,
            ),
            const SizedBox(
              width: 25,
            ),
            const Icon(
              Icons.more_vert,
              size: 22,
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            controller.isdisplaywindowattach.value = false;
          },
          child: Stack(
            children: [
              Positioned.fill(
                  child: Image.asset(
                    "assets/whatsapp_bg_image.png",
                    fit: BoxFit.cover,
                  )),
              Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: controller.getAllUserMessages(), // Replace 'chatId' with the actual chat ID
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(child: Text("Error loading messages."));
                        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text("No messages found."));
                        }else{
                          final messages = snapshot.data!.docs;
                          return ListView.builder(
                            itemCount: messages.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              return messagelayout(
                                message: message['text'] ?? "",
                                alignment: message['senderId'] ==
                                    controller.currentUser!.uid
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                createAt: message["timestamp"]==null?DateTime.now():message['timestamp'].toDate(),
                                isSeen:message['status'] == 'seen',
                                isShowTick: message["senderId"]==controller.currentUser!.uid,
                                messageBgColor: message['senderId'] ==
                                    controller.currentUser!.uid
                                    ? senderMessageColor
                                    : messageColor,
                                onLongPress: () {
                                  // Handle long press on message
                                },
                                onSwipe: () {
                                  // Handle swipe on message
                                },
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color: appBarColor,
                                  borderRadius: BorderRadius.circular(25)),
                              height: 50,
                              child: TextField(
                                controller: controller.textmessagecontroller,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    controller.isdisplaysendicon.value = true;
                                  } else {
                                    controller.isdisplaysendicon.value = false;
                                  }
                                },
                                onTap: () {
                                  controller.isdisplaywindowattach.value = false;
                                },
                                decoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                    prefixIcon: const Icon(
                                      Icons.emoji_emotions,
                                      color: greyColor,
                                    ),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Wrap(
                                        children: [
                                          Transform.rotate(
                                              angle: -0.5,
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.isdisplaywindowattach
                                                      .value =
                                                  !controller.isdisplaywindowattach
                                                      .value;
                                                },
                                                child: const Icon(
                                                  Icons.attach_file,
                                                  color: greyColor,
                                                ),
                                              )),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          const Icon(
                                            Icons.camera_alt,
                                            color: greyColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    hintText: "messages",
                                    border: InputBorder.none),
                              ),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            controller.sendMessage();
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: tabColor),
                            child: Center(
                              child: Obx(() => Icon(
                                controller.isdisplaysendicon.value
                                    ? Icons.send_outlined
                                    : Icons.mic,
                                color: Colors.white,
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Obx(() => controller.isdisplaywindowattach.value
                  ? Positioned(
                  bottom: 65,
                  left: 15,
                  right: 15,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 20),
                    decoration: BoxDecoration(
                      color: bottomAttachContainerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            attachwindowitem(
                              icon: Icons.document_scanner,
                              color: Colors.deepPurpleAccent,
                              title: "Document",
                              ontap: () {},
                            ),
                            attachwindowitem(
                              icon: Icons.camera_alt,
                              color: Colors.pinkAccent,
                              title: "Camera",
                              ontap: () {},
                            ),
                            attachwindowitem(
                              icon: Icons.image,
                              color: Colors.purpleAccent,
                              title: "Gallery",
                              ontap: () {},
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            attachwindowitem(
                              icon: Icons.headphones,
                              color: Colors.deepOrange,
                              title: "Audio",
                              ontap: () {},
                            ),
                            attachwindowitem(
                              icon: Icons.location_on,
                              color: Colors.green,
                              title: "Location",
                              ontap: () {},
                            ),
                            attachwindowitem(
                              icon: Icons.account_circle,
                              color: Colors.deepPurpleAccent,
                              title: "Contact",
                              ontap: () {},
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            attachwindowitem(
                              icon: Icons.bar_chart,
                              color: tabColor,
                              title: "Poll",
                              ontap: () {},
                            ),
                            attachwindowitem(
                              icon: Icons.gif_box_outlined,
                              color: Colors.indigoAccent,
                              title: "Gif",
                              ontap: () {},
                            ),
                            attachwindowitem(
                              icon: Icons.videocam_rounded,
                              color: Colors.lightGreen,
                              title: "video",
                              ontap: () {},
                            )
                          ],
                        )
                      ],
                    ),
                  ))
                  : const SizedBox())
            ],
          ),
        ));
  }
}
