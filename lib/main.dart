import 'package:connectana/controller/all_in_controller.dart';
import 'package:connectana/view/auth/login_screen.dart';
import 'package:connectana/view/home/app_home_screen.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

final AllInController controller = Get.put(AllInController());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: FutureBuilder(
        future: controller.isUserLogedIn(),
        builder: (contect, authResult) {
          if (authResult.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            );
          } else {
            if (authResult.data == true) {
              // return Demo();
              return AppHomeScreen();
            }
            return const LoginSignUpScreen();
            // return const LoginScreen(
            //   status: true,
            // );
          }
        },
      ),
    );
  }
}


// [{"card_id":"116","user_id":"111","card_name":"Personal","prefix":"","first_name":"RRU","middle_name":"","last_name":"RR","suffix":"","accreditations":"","preferred_name":"","maiden_name":"","pronouns":"","title":"RR","department":"","company":"RR","headline":"","color":"#01efbd","is_profile_image":false,"badge":{"Mail":"rr@gmail.com","Mobile":"1234567890","Location":"","Website":["http://web","http://web"],"Link":["http://link","http://link1"],"Facebook":"","Instagram":"","Whatsapp":"","Twitter":"","Linkedin":"","Youtube":"","Telegram":"","Skype":"","Paypal":"","Wechat":"","Calendly":"","Note":""},"website_link":[],"profile":"","logo":""}]