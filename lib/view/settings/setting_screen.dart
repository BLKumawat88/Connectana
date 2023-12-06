import 'package:connectana/controller/all_in_controller.dart';
import 'package:connectana/view/auth/login_screen.dart';
import 'package:connectana/view/settings/send_feedback.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../forgotpassword/forgot_password.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  final AllInController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getGeneralSectionDataOfSettings();
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(child: GetBuilder<AllInController>(
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "PLAN",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        onTap: () {
                          // controller.getPatientProfile();
                        },
                        child: const ListTile(
                          leading: Text(
                            "Connectana Business",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "GENERAL",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => SendFeedback());
                  },
                  child: const Card(
                    child: ListTile(
                      leading: Text(
                        "Contact support and Feedback",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: controller.generalData
                          .map(
                            (data) => InkWell(
                              onTap: () {
                                if (data['link'] != "") {
                                  launchUrlString("${data['link']}");
                                }
                              },
                              child: ListTile(
                                leading: Text(
                                  data['title'],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: const Icon(
                                    Icons.arrow_forward_ios_outlined),
                              ),
                            ),
                          )
                          .toList()),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "FOLLOW US",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: controller.socialData
                          .map(
                            (data) => InkWell(
                              onTap: () async {
                                print(data['link'].runtimeType);
                                if (data['link'] == "") {
                                } else {
                                  await launch("${data['link']}");
                                  // await launchUrlString("${data['link']}");
                                }
                              },
                              child: ListTile(
                                leading: Text(
                                  data['title'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: const Icon(
                                    Icons.arrow_forward_ios_outlined),
                              ),
                            ),
                          )
                          .toList()),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "ACCOUNT",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        onTap: () {
                          GetStorage().remove('isuser_login');
                          Get.offAll(const LoginSignUpScreen());
                        },
                        child: const ListTile(
                          leading: Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          trailing: Icon(Icons.logout),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => const ForgotPassword());
                        },
                        child: const ListTile(
                          leading: Text(
                            "Reset password",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Icon(Icons.settings_backup_restore_sharp),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.deleteAccount();
                        },
                        child: const ListTile(
                          leading: Text(
                            "Delete Account",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(Icons.delete_forever),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        )),
      ),
    );
  }
}
