import 'package:connectana/controller/all_in_controller.dart';
import 'package:connectana/controller/comman_dailog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../theme/app_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  AllInController controller = Get.find();
  late bool _password = true;
  late bool _c_password = true;

  Map requiredDataForSignUp = {
    "name": "",
    "email": "",
    "password": "",
    "confirm_password": "",
    "fcmToken": "XXXXXXX",
    "deviceType": "XXXXXXX"
  };

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 250,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: requiredDataForSignUp['name'],
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "User Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    onSaved: (value) {
                      requiredDataForSignUp['name'] = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'User Name Required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: requiredDataForSignUp['email'],
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    onSaved: (value) {
                      requiredDataForSignUp['email'] = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email Required';
                      } else if (!RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(value)) {
                        return "Required valid Email format";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: requiredDataForSignUp['password'],
                    keyboardType: TextInputType.text,
                    obscureText: _password,
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _password ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _password = !_password;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    onSaved: (value) {
                      requiredDataForSignUp['password'] = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password Required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: requiredDataForSignUp['confirm_password'],
                    keyboardType: TextInputType.text,
                    obscureText: _c_password,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _c_password ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _c_password = !_c_password;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    onSaved: (value) {
                      requiredDataForSignUp['confirm_password'] = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm Password Required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: AppButton(
                        buttonType: "simpleButton",
                        buttonText: "SIGNUP",
                        onPressed: () {
                          _formKey.currentState!.save();
                          if (_formKey.currentState!.validate()) {
                            if (requiredDataForSignUp['password'] !=
                                requiredDataForSignUp['confirm_password']) {
                              CommanDialog.showErrorDialog(
                                  description: "Password did not match");
                            } else {
                              controller.signUp(requiredDataForSignUp);
                            }
                          }
                        },
                        buttonbgColor: const Color(0xFFDE0000),
                        buttonTextColor: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Text(
                        "Aready have an account? Sign In",
                        style: TextStyle(
                          color: Color(0xFF01EFBD),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
