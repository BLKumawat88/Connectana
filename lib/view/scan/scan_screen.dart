import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectana/controller/all_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../qrcodescanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final List moreActionButton = const [
    {"title": "Choose a photo", "id": 1},
    {"title": "Take a photo", "id": 2},
    {"title": "Cancel", "id": 6},
  ];
  File? selectedImage;
  String base64Image = "";

  void addImage() {
    Get.bottomSheet(
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Container(
          color: Colors.white,
          height: 170,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...moreActionButton.map((data) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextButton(
                          onPressed: () {
                            if (data['id'] == 1) {
                              Get.back();
                              chooseImage("Gallery");
                            } else if (data['id'] == 2) {
                              Get.back();
                              chooseImage("camera");
                            } else {
                              Get.back();
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
                                color: const Color(0xFFD1D1D1), width: 0.5),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AllInController controller = Get.find();

  Future<void> chooseImage(type) async {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
    } else {
      image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        log(base64Image);
        controller.saveScanImage(base64Image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        title: const Text(
          "Scan",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton.icon(
              onPressed: addImage,
              icon: const Icon(Icons.add),
              label: const Text('Add Image'))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: addImage,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: selectedImage != null
                      ? Image.file(
                          selectedImage!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        )
                      : Image.network(
                          "https://miro.medium.com/max/1400/1*gkc2iPNeEX_h1V4YmXbV1g.jpeg",
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 100),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Take a picture of a paper business card and receive an accurate, human verified contact within 24 hours.",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: "monospace"),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => QRViewExample());
        },
        icon: const Icon(
          Icons.camera_alt,
        ),
        label: const Text("SCAN CARD"),
      ),
    );
  }
}
