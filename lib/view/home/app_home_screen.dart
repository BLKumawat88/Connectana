import 'package:connectana/controller/all_in_controller.dart';
import 'package:connectana/view/card/card_screen.dart';
import 'package:connectana/view/contacts/contacts_screen.dart';
import 'package:connectana/view/more/more_screen.dart';
import 'package:connectana/view/scan/scan_screen.dart';
import 'package:connectana/view/settings/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({Key? key}) : super(key: key);

  @override
  State<AppHomeScreen> createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  int currentIndex = 0;

  final screens = [
    CardScreen(),
    const ScanScreen(),
    const ContactsScreen(),
    MoreScreen(),
    SettingScreen(),
  ];

  final appBarTitle = ['Cards', 'Scan', 'Contacts', 'More', 'Settings'];

  AllInController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: currentIndex == 1
          ? null
          : AppBar(
              backgroundColor: const Color(0xFFFAFAFA),
              elevation: 0,
              title: Text(
                appBarTitle[currentIndex],
                style: const TextStyle(color: Colors.black),
              ),
              actions: [
                currentIndex == 0
                    ? IconButton(
                        onPressed: () {
                          if (currentIndex == 0) {
                            controller.requiredDataForCreateCard["profile"] =
                                "";
                            controller.checkCardLimit();
                          }
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      )
                    : const SizedBox()
              ],
            ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(
          () {
            currentIndex = index;
          },
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: "Cards",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reviews),
            label: "Scan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Contacts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: "More",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
