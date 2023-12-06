import 'package:connectana/controller/all_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendFeedback extends StatelessWidget {
  SendFeedback({Key? key}) : super(key: key);

  // String email = 'support@connectana.app';
  final _formKey = GlobalKey<FormState>();
  TextEditingController inputText = TextEditingController();
  TextEditingController email = TextEditingController();
  AllInController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Send Feedback',
          style: TextStyle(color: Colors.black),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.grey,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Map requiredData = {
                  "user_id": controller.userId,
                  'email': email.text,
                  "desc": inputText.text
                };
                controller.sendFeeback(requiredData);
              }
            },
            child: const Text(
              'Send',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: 40,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
            const Divider(
              height: 1,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(fontSize: 18),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                          hintText: "xyz@gmail.com",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintMaxLines: 2,
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Email Required';
                          } else {
                            return null;
                          }
                        }),
                      ),
                    ),
                  ),
                  // Text(
                  //   email,
                  //   style: const TextStyle(fontSize: 18),
                  // ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.black,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 0,
              ),
              height: 60,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "We'll respond to this email address.",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.black,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 0,
              ),
              height: 150,
              width: double.infinity,
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextFormField(
                  controller: inputText,
                  decoration: const InputDecoration(
                    hintText:
                        "We'd love to hear what we can do to make Connectana even better!",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintMaxLines: 2,
                  ),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please give your sugestion';
                    } else {
                      return null;
                    }
                  }),
                ),
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.grey,
              thickness: 2,
            ),
            Container(
              width: double.infinity,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
