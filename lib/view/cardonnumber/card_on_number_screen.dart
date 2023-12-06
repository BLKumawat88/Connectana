import 'dart:developer';

import 'package:connectana/view/theme/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/all_in_controller.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class CardOnNumerScreen extends StatefulWidget {
  final int color;
  const CardOnNumerScreen({Key? key, required this.color}) : super(key: key);

  @override
  State<CardOnNumerScreen> createState() => _CardOnNumerScreenState();
}

class _CardOnNumerScreenState extends State<CardOnNumerScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController phonenumber = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController message = TextEditingController();

  AllInController controller = Get.find();

  @override
  Widget build(BuildContext context) {
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
                    onSaved: (value) {},
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () async {
                    try {
                      final FullContact contact =
                          await FlutterContactPicker.pickFullContact();
                      print('abc');
                      setState(
                        () {
                          phonenumber.text =
                              contact.phones[0].number.toString();
                          name.text = contact.name!.firstName.toString();
                          controller.sendCardOnMobile['name'] = name.text;
                          controller.sendCardOnMobile['mobile'] =
                              phonenumber.text;
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
              controller: phonenumber,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Phone Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Required Mobile Number";
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
              onSaved: (value) {
                controller.sendCardOnMobile['message'] = value;
              },
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
                      controller.sendCardOnMobile['name'] = name.text;
                      controller.sendCardOnMobile['mobile'] = phonenumber.text;
                      controller.sendCardOnMail['message'] = message.text;
                      controller.sendCardNumber();
                    }
                  },
                  buttonbgColor: Colors.white,
                  buttonTextColor: Color(widget.color)),
            )
          ],
        ),
      ),
    );
  }
}
