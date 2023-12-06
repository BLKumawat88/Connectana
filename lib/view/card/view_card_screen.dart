import 'package:connectana/controller/all_in_controller.dart';
import 'package:connectana/controller/comman_dailog.dart';
import 'package:connectana/view/qrcode/qrcode_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:url_launcher/url_launcher_string.dart';

// ignore: must_be_immutable
class ViewCardScreen extends StatelessWidget {
  final Map cardDetails;
  final List moreActionButton = const [
    {"title": "Send", "id": 1},
    {"title": "Write to NFC", "id": 2},
    {"title": "Preview", "id": 3},
    {"title": "Edit", "id": 4},
    {"title": "Delete", "id": 5},
    {"title": "Cancel", "id": 6},
  ];

  ViewCardScreen({Key? key, required this.cardDetails}) : super(key: key);
  void moreAction(context) {
    Get.bottomSheet(
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...moreActionButton.map(
                    (data) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextButton(
                            onPressed: () async {
                              if (data['id'] == 1) {
                                qrCodeScreen(context);
                              } else if (data['id'] == 2) {
                                _ndefWrite();
                              } else if (data['id'] == 3) {
                                await launchUrlString(cardDetails['NFC_link']);
                              } else if (data['id'] == 6) {
                                Get.back();
                              } else if (data['id'] == 5) {
                                Map requiredData = {
                                  "user_id": controller.userId,
                                  "card_id": cardDetails['id']
                                };
                                controller.deleteCard(requiredData);
                              } else if (data['id'] == 4) {
                                Get.back();
                                controller
                                    .getDataForEditCard(cardDetails['id']);
                              }
                            },
                            child: Text(
                              data['title'],
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFD1D1D1),
                                width: 0.5,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void qrCodeScreen(BuildContext context) {
    controller.sendCardOnMobile['card_id'] = cardDetails['id'];
    controller.sendCardOnMail['card_id'] = cardDetails['id'];
    Get.to(
      () => QrCodeScreen(
          qrCodeUrl: cardDetails['NFC_link'],
          color: _colorFromHex(cardDetails['color'])),
    );
    // Get.bottomSheet(const QrCodeScreen(),
    //     isScrollControlled: true, ignoreSafeArea: false);
  }

  Widget badges(icon, title, color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
              backgroundColor: Color(_colorFromHex(cardDetails['color'])),
              child: Image.asset(icon, width: 30)),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }

  final AllInController controller = Get.find();
  ValueNotifier<dynamic> result = ValueNotifier(null);

  void _ndefWrite() {
    Get.back();
    // CommanDialog.showErrorDialog(description: "${result.value}");
    CommanDialog.showLoading(title: "Tap NFC tag back to Phone");
    try {
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        Get.back();
        var ndef = Ndef.from(tag);
        if (ndef == null || !ndef.isWritable) {
          result.value = 'Tag is not ndef writable';
          CommanDialog.showErrorDialog(description: "${result.value}");
          NfcManager.instance.stopSession(errorMessage: result.value);
          return;
        }

        NdefMessage message = NdefMessage([
          NdefRecord.createUri(Uri.parse(cardDetails['NFC_link'])),
        ]);

        try {
          await ndef.write(
            message,
          );
          result.value = 'Success to Ndef Write"';
          CommanDialog.showErrorDialog(description: "${result.value}");
          NfcManager.instance.stopSession();
        } catch (e) {
          result.value = e;
          CommanDialog.showErrorDialog(description: "${result.value}");
          NfcManager.instance
              .stopSession(errorMessage: result.value.toString());
          return;
        }
      });
    } catch (error) {
      print(error);
    }
  }

  int _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return int.parse('FF$hexCode', radix: 16);
    // }
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Color(int.parse(cardDetails['color']))));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: const Color(0xFFFAFAFA),
          title: Text(
            "${cardDetails['first_name']}",
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.getDataForEditCard(cardDetails['id']);
              },
              child: const Text(
                'Edit',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            IconButton(
              onPressed: () {
                moreAction(context);
              },
              icon: const Icon(
                Icons.more_horiz,
                size: 28,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 50,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: <Widget>[
                          //stack overlaps widgets
                          ClipPath(
                            clipper:
                                WaveClipper(), //set our custom wave clipper
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                              child: Container(
                                color:
                                    Color(_colorFromHex(cardDetails['color'])),
                                height: 360,
                              ),
                            ),
                          ),
                          ClipPath(
                            //upper clippath with less height
                            clipper:
                                WaveClipper(), //set our custom wave clipper.

                            child: Container(
                              width: double.infinity,
                              color: Colors.green,
                              height: 350,
                              alignment: Alignment.center,
                              child: Image.network(
                                cardDetails['profile'],
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: ((context, error, stackTrace) {
                                  return const Text(
                                    "Image Error",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  );
                                }),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 10,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                    height: 70,
                                    width: 70,
                                    child: Image.network(
                                      cardDetails['logo'],
                                      height: double.infinity,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          ((context, error, stackTrace) {
                                        return const Text(
                                          "Image Error",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                "${cardDetails['full_name']} ${cardDetails['suffix']} (${cardDetails['maiden_name']}) ${cardDetails['accreditations']}",
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              cardDetails['department'],
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              cardDetails['company'],
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              cardDetails['headline'],
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            cardDetails['badge']['Mail'] != ""
                                ? badges("assets/images/email.png",
                                    cardDetails['badge']['Mail'], 0xFF3EB559)
                                : const SizedBox(),
                            cardDetails['badge']['Mobile'] != null &&
                                    cardDetails['badge']['Mobile'] != ""
                                ? badges("assets/images/phone.png",
                                    cardDetails['badge']['Mobile'], 0xFF3EB559)
                                : const SizedBox(),
                            cardDetails['badge']['Location'] != "" &&
                                    cardDetails['badge']['Location'] != null
                                ? badges(
                                    "assets/images/location.png",
                                    cardDetails['badge']['Location'],
                                    0xFF3EB559)
                                : const SizedBox(),
                            cardDetails['badge']['Website'] != "" &&
                                    cardDetails['badge']['Website'] != null
                                ? Column(
                                    children: [
                                      ...cardDetails['badge']['Website']
                                          .map((data) {
                                        return badges("assets/images/web.png",
                                            data, 0xFF3EB559);
                                      }).toList()
                                    ],
                                  )
                                : const SizedBox(),
                            cardDetails['badge']['Link'] != "" &&
                                    cardDetails['badge']['Link'] != null
                                ? Column(
                                    children: [
                                      ...cardDetails['badge']['Link']
                                          .map((data) {
                                        return badges("assets/images/link.png",
                                            data, 0xFF3EB559);
                                      }).toList()
                                    ],
                                  )
                                : const SizedBox(),
                            cardDetails['badge']['Instagram'] != "" &&
                                    cardDetails['badge']['Instagram'] != null
                                ? badges(
                                    "assets/images/instagram.png",
                                    cardDetails['badge']['Instagram'],
                                    0xFF3EB559)
                                : const SizedBox(),
                            cardDetails['badge']['Whatsapp'] != "" &&
                                    cardDetails['badge']['Whatsapp'] != null
                                ? badges(
                                    "assets/images/whatsapp.png",
                                    cardDetails['badge']['Whatsapp'],
                                    0xFF3EB559)
                                : const SizedBox(),
                            cardDetails['badge']['Twitter'] != "" &&
                                    cardDetails['badge']['Twitter'] != null
                                ? badges("assets/images/twitter.png",
                                    cardDetails['badge']['Twitter'], 0xFF3EB559)
                                : const SizedBox(),
                            cardDetails['badge']['Linkedin'] != "" &&
                                    cardDetails['badge']['Linkedin'] != null
                                ? badges(
                                    "assets/images/linkedin.png",
                                    cardDetails['badge']['Linkedin'],
                                    0xFF3EB559)
                                : const SizedBox(),
                            cardDetails['badge']['Youtube'] != "" &&
                                    cardDetails['badge']['Youtube'] != null
                                ? badges("assets/images/youtube.png",
                                    cardDetails['badge']['Youtube'], 0xFF3EB559)
                                : const SizedBox(),
                            cardDetails['badge']['Telegram'] != "" &&
                                    cardDetails['badge']['Telegram'] != null
                                ? badges(
                                    "assets/images/telegram.png",
                                    cardDetails['badge']['Telegram'],
                                    0xFF3EB559)
                                : const SizedBox(),
                            cardDetails['badge']['Skype'] != "" &&
                                    cardDetails['badge']['Skype'] != null
                                ? badges("assets/images/skype.png",
                                    cardDetails['badge']['Skype'], 0xFF3EB559)
                                : const SizedBox(),
                            cardDetails['badge']['Paypal'] != "" &&
                                    cardDetails['badge']['Paypal'] != null
                                ? badges("assets/images/paypal.png",
                                    cardDetails['badge']['Paypal'], 0xFF3EB559)
                                : const SizedBox(),
                            cardDetails['badge']['Wechat'] != "" &&
                                    cardDetails['badge']['Wechat'] != null
                                ? badges("assets/images/wechat.png",
                                    cardDetails['badge']['Wechat'], 0xFF3EB559)
                                : const SizedBox(),
                            cardDetails['badge']['Calendly'] != "" &&
                                    cardDetails['badge']['Calendly'] != null
                                ? badges(
                                    "assets/images/cnd.png",
                                    cardDetails['badge']['Calendly'],
                                    0xFF3EB559)
                                : const SizedBox(),
                            cardDetails['badge']['Note'] != "" &&
                                    cardDetails['badge']['Note'] != null
                                ? badges("assets/images/cnd.png",
                                    cardDetails['badge']['Note'], 0xFF3EB559)
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(_colorFromHex(cardDetails['color'])),
          onPressed: () {},
          label: TextButton.icon(
            onPressed: () {
              qrCodeScreen(context);
            },
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
            label: const Text(
              'SEND',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    var path = Path();
    path.lineTo(0, h - 40);
    path.quadraticBezierTo(
      w * 0.5,
      h + 40,
      w,
      h - 120,
    );
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 40.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 100);
    var secondEndPoint = Offset(size.width, size.height - 70);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}
