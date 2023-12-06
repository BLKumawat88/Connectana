import 'dart:developer';

import 'package:connectana/controller/all_in_controller.dart';
import 'package:connectana/view/theme/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class CardOnEmail extends StatefulWidget {
  final int color;
  const CardOnEmail({Key? key, required this.color}) : super(key: key);

  @override
  State<CardOnEmail> createState() => _CardOnEmailState();
}

class _CardOnEmailState extends State<CardOnEmail> {
  final _formKey = GlobalKey<FormState>();

  AllInController controller = Get.find();

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("build");
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: name,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        // borderSide: const BorderSide(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () async {
                    print("Get contact 1234");
                    try {
                      print("Get contact 1");
                      final FullContact contact =
                          await FlutterContactPicker.pickFullContact();
                      print('abc');
                      setState(
                        () {
                          if (contact.emails.isNotEmpty) {
                            emailcontroller.text =
                                contact.emails[0].email.toString();
                            controller.sendCardOnMail['email'] =
                                emailcontroller.text;
                          }
                          name.text = contact.name!.firstName.toString();
                          controller.sendCardOnMail['name'] = name.text;
                        },
                      );
                    } catch (error) {
                      log("errror $error");
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.person_pin_rounded,
                      color: Color(widget.color),
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailcontroller,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Required Email Address";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: message,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              minLines: 2,
              maxLines: 2,
              // keyboardType: TextInputType.text,

              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Message",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  // borderSide: const BorderSide(),
                ),
              ),
              onSaved: (value) {},
            ),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                  buttonType: "simpleButton",
                  buttonText: "SEND",
                  onPressed: () {
                    print("Send");
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      controller.sendCardOnMail['email'] = emailcontroller.text;
                      controller.sendCardOnMail['name'] = name.text;
                      controller.sendCardOnMail['message'] = message.text;
                      print(controller.sendCardOnMail);
                      controller.sendCardMail();
                    }
                  },
                  buttonbgColor: Colors.white,
                  buttonTextColor: Color(widget.color)),
            ),
            // ElevatedButton(
            //   child: const Text('Request permission'),
            //   onPressed: () async {
            //     final granted = await FlutterContactPicker.requestPermission();
            //     showDialog(
            //         context: context,
            //         builder: (context) => AlertDialog(
            //             title: const Text('Granted: '),
            //             content: Text('$granted')));
            //   },
            // ),
            // ElevatedButton(
            //   child: const Text('Check permission'),
            //   onPressed: () async {
            //     final granted = await FlutterContactPicker.hasPermission();
            //     showDialog(
            //         context: context,
            //         builder: (context) => AlertDialog(
            //             title: const Text('Granted: '),
            //             content: Text('$granted')));
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
