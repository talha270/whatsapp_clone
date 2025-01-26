import 'package:flutter/material.dart';

import '../../../app/global/widgets/profile_widget.dart';
import '../../../app/theme/style.dart';

class CallContactsPage extends StatelessWidget {
  const CallContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Contacts"),
      ),
      body: ListView.builder(itemCount:20, itemBuilder: (context, index) {
        return ListTile(
          leading: SizedBox(
            width: 50,
            height: 50,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Profilewidget()),
          ),
          title: const Text("Username"),
          subtitle: const Text("Hey there! I'm using WhatsApp"),
          trailing: const Wrap(
            children: [
              Icon(Icons.call, color: tabColor, size: 22,),
              SizedBox(width: 15,),
              Icon(Icons.videocam_rounded, color: tabColor, size: 25,),
            ],
          ),
        );
      }),
    );
  }
}


