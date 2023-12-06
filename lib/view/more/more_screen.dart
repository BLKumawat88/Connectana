import 'package:connectana/controller/all_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MoreScreen extends StatelessWidget {
  MoreScreen({Key? key}) : super(key: key);

  final List moreData = [
    {
      "image": "assets/images/more1.png",
      "heading": "WEB",
      "title": "Switch to Desktop",
      "subtitle": "Access more features on the web"
    },
    {
      "image": "assets/images/more2.png",
      "heading": "WEB",
      "title": "Email Signatures",
      "subtitle": "Create a signature that likes to your business card"
    },
    {
      "image": "assets/images/more3.png",
      "heading": "WEB",
      "title": "Vietual Backgrounds",
      "subtitle": "Make a virtual background with QR code"
    },
    {
      "image": "assets/images/more4.png",
      "heading": "WEB",
      "title": "Connect Ana Widget",
      "subtitle": "Share your card even faster with the widget"
    },
  ];

  AllInController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getMoreSectionData();
    });
    return Scaffold(
        // backgroundColor: const Color(AppCommonTheme.appBGColor),
        body: SingleChildScrollView(child: GetBuilder<AllInController>(
      builder: (controller) {
        return Column(
          children: [
            ...controller.moreSectionData
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        if (e['link'] == "") {
                        } else {
                          await launchUrlString("${e['link']}");
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xFFE5F5EA),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                width: 100,
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset("assets/images/more3.png"),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e['title'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      e['description'],
                                      style: const TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList()
          ],
        );
      },
    )));
  }
}
