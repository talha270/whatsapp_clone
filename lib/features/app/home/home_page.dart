import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone_practice/features/app/home/contacts_page.dart';
import 'package:whatsapp_clone_practice/features/app/settings/settings_pages.dart';
import 'package:whatsapp_clone_practice/features/call/presentation/pages/call_contacts_page.dart';
import 'package:whatsapp_clone_practice/features/call/presentation/pages/call_history_page.dart';
import 'package:whatsapp_clone_practice/features/chat/presentation/pages/chat_page.dart';
import 'package:whatsapp_clone_practice/features/status/presentation/pages/status_page.dart';

import '../../controllers/main_home_controller.dart';
import '../theme/style.dart';

class HomePage extends StatelessWidget {

  HomePage({super.key});

  final HomeController controller = Get.put(HomeController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          _getAppBarTitle(controller.selectedIndex.value),
          style: const TextStyle(
            fontSize: 25,
            color: greyColor,
            fontWeight: FontWeight.w600,
          ),
        )),
        actions: _buildAppBarActions(),
      ),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        children: [
          ChatPage(),
          StatusPage(),
          CallHistoryPage(),
        ],
      ),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(

              // backgroundColor: Colors.red,
          currentIndex: controller.selectedIndex.value,
          onTap: controller.onBottomNavTap,
          elevation: 20,
          selectedItemColor: tabColor,
          // selectedFontSize: 16,
          // unselectedFontSize: 14,
          useLegacyColorScheme: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.chat, size: 30), label: "Chat"),
            BottomNavigationBarItem(
                icon: Icon(Icons.upcoming, size: 30), label: "Status"),
            BottomNavigationBarItem(
                icon: Icon(Icons.phone, size: 30), label: "Call"),
          ],
        ),
      ),
      floatingActionButton: Obx(
            () => FloatingActionButton(
          elevation: 10,
          backgroundColor: tabColor,
          onPressed: () =>
              _handleFloatingActionButtonTap(controller.selectedIndex.value),
          child: _getFloatingActionIcon(controller.selectedIndex.value),
        ),
      ),
    );
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return "WhatsApp";
      case 1:
        return "Updates";
      case 2:
        return "Calls";
      default:
        return "WhatsApp";
    }
  }

  List<Widget> _buildAppBarActions() {
    return [
      const Icon(
        Icons.camera_alt_outlined,
        color: greyColor,
        size: 28,
      ),
      const SizedBox(width: 25),
      const Icon(Icons.search, color: greyColor, size: 28),
      const SizedBox(width: 10),
      PopupMenuButton<String>(
        icon: const Icon(
          Icons.more_vert,
          color: greyColor,
          size: 28,
        ),
        color: appBarColor,
        onSelected: (value) {
          if (value == "Settings") {
            Get.to(() => SettingsPages());
          }
        },
        itemBuilder: (context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: "Settings",
            child: const Text('Settings'),
          ),
        ],
      ),
    ];
  }

  Icon _getFloatingActionIcon(int index) {
    switch (index) {
      case 0:
        return const Icon(Icons.chat);
      case 1:
        return const Icon(Icons.camera_alt);
      case 2:
        return const Icon(Icons.add_call);
      default:
        return const Icon(Icons.chat);
    }
  }

  void _handleFloatingActionButtonTap(int index) {
    if (index == 0) {
      Get.to(() => Contactspage());
    } else if (index == 2) {
      Get.to(() => const CallContactsPage());
    }
  }
}
