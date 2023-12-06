import 'package:connectana/view/qrcode/generate_qr_code_screen.dart';
import 'package:flutter/material.dart';

import '../cardonmail/card_on_email_screen.dart';
import '../cardonnumber/card_on_number_screen.dart';

class QrCodeScreen extends StatefulWidget {
  final String qrCodeUrl;
  final int color;
  const QrCodeScreen({Key? key, required this.qrCodeUrl, required this.color})
      : super(key: key);

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  int selctionValue = 1;

  updateSelectionValue(int value) {
    setState(() {
      selctionValue = value;
      print("selctionValue $selctionValue");
    });
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Color(widget.color)));
    return Scaffold(
      backgroundColor: Color(widget.color),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(widget.color),
        centerTitle: true,
        title: const Text('Send New Card'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  selctionValue == 1
                      ? GenerateQRCodeScreen(
                          qrCodeUrl: widget.qrCodeUrl, color: widget.color)
                      : selctionValue == 2
                          ? CardOnEmail(
                              color: widget.color,
                            )
                          : CardOnNumerScreen(color: widget.color),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.green, spreadRadius: 1),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            updateSelectionValue(1);
                          },
                          child: Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              color: selctionValue == 1
                                  ? Colors.white
                                  : Color(widget.color),
                              boxShadow: const [
                                BoxShadow(color: Colors.white, spreadRadius: 1),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.qr_code),
                                Text("Code"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            updateSelectionValue(2);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selctionValue == 2
                                  ? Colors.white
                                  : Color(widget.color),
                              boxShadow: const [
                                BoxShadow(color: Colors.white, spreadRadius: 1),
                              ],
                            ),
                            height: 75,
                            width: 75,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.email),
                                Text("Email"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            updateSelectionValue(3);
                          },
                          child: Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: selctionValue == 3
                                  ? Colors.white
                                  : Color(widget.color),
                              boxShadow: const [
                                BoxShadow(color: Colors.white, spreadRadius: 1),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.textsms),
                                Text("Text"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
