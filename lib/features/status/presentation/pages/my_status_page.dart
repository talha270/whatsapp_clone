import 'package:flutter/material.dart';

import '../../../app/global/widgets/profile_widget.dart';
import '../../../app/theme/style.dart';
import 'package:timeago/timeago.dart' as timeago;

class MyStatusPage extends StatelessWidget {
  const MyStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Status"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Profilewidget(),
                  ),
                ),
                const SizedBox(width: 15,),
                Expanded(
                  child: Text(
                    timeago.format(DateTime.now().subtract(Duration(seconds: 5))),
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),

                PopupMenuButton<String>(
                  icon:Icon(Icons.more_vert, color: greyColor.withOpacity(.5),),
                  color: appBarColor,
                  iconSize: 28,
                  onSelected: (value) {},
                    offset: Offset(-22, 40),
                  itemBuilder: (context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: "Delete",
                      child: GestureDetector(onTap: () {
                        
                      },
                        child: const Text('Delete'),),),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
