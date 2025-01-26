import 'package:flutter/material.dart';
import 'package:whatsapp_clone_practice/features/app/global/date/date_formater.dart';
import 'package:whatsapp_clone_practice/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_practice/features/app/theme/style.dart';
import 'package:whatsapp_clone_practice/features/status/presentation/pages/my_status_page.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child:Profilewidget(),
                      ),
                    ),
                    Positioned(right: 10,bottom: 8,
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: tabColor,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(width: 2,color: backgroundColor)
                        ),
                        child: const Icon(Icons.add,size: 20,),
                      ),)
                  ],
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("My Status", style: TextStyle(fontSize: 16)),
                      SizedBox(
                        height: 2,
                      ),
                      Text("Tap to add your status update", style: TextStyle(color: greyColor)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyStatusPage(),));
                  },
                  child: Icon(
                    Icons.more_horiz,
                    color: greyColor.withOpacity(.5),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(height: 10,),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Recent Updates",style: TextStyle(
                  fontSize: 15, color: greyColor, fontWeight: FontWeight.w500)),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    margin: EdgeInsets.all(3),
                    width: 55,
                    height: 55,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Profilewidget(),
                    ),
                  ),
                  title: const Text("UserName",style: TextStyle(fontSize: 16),),
                  subtitle: Text(
                    formatDateTime(dateTime: DateTime.now())
                  ),
                );
            },)
          ],
        ),
      ),
    );
  }
}

