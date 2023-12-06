import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectana/controller/all_in_controller.dart';
import 'package:connectana/controller/comman_dailog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// A simple function without using a class:

// Color _colorFromHex(String hexColor) {
//   final hexCode = hexColor.replaceAll('#', '');
//   return Color(int.parse('FF$hexCode', radix: 16));
// }
// You can use it like this:

// Color color1 = _colorFromHex("b74093");
// Color color2 = _colorFromHex("#b74093");

class AddNewCardScreen extends StatefulWidget {
  final String type;

  const AddNewCardScreen({Key? key, required this.type}) : super(key: key);
  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  final List moreActionButton = const [
    {"title": "Choose a photo", "id": 1},
    {"title": "Take a photo", "id": 2},
    {"title": "Cancel", "id": 6},
  ];
  File? selectedImage;
  String base64Image = "";

  //Image of Logo
  File? selectedImageForLogo;
  String base64ImageForLogo = "";
  String colorToSendBackEnd = "#01efbd";

  int _colorFromHex(String hexColor) {
    if (widget.type == "edit") {
      colorToSendBackEnd = hexColor;
      controller.requiredDataForCreateCard["color"] = colorToSendBackEnd;
    } else {
      colorToSendBackEnd = "#$hexColor";
    }
    print("Send color to back end $colorToSendBackEnd");
    // String con = "#";
    // if (hexColor.contains(con)) {
    //   print("IN IF Conditions");
    //   return int.parse('FF$hexColor', radix: 16);
    // } else {
    // print("IN ELSE");
    final hexCode = hexColor.replaceAll('#', '');
    return int.parse('FF$hexCode', radix: 16);
    // }
  }

  int colorValue = 0xFFf44336;
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
        // base64Image = "$selectedImage";

        log("base64Image1234 $base64Image");
        // controller.requiredDataForCreateCard['profile'] = base64Image;
        controller.requiredDataForCreateCard['profile'] = base64Image;
        // log(controller.requiredDataForCreateCard['profile']);
        // won't have any error now
      });
    }
  }

  Future<void> chooseImageForLogo(type) async {
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
        selectedImageForLogo = File(image.path);
        base64ImageForLogo =
            base64Encode(selectedImageForLogo!.readAsBytesSync());
        // base64Image = "$selectedImage";

        log("base64Image1234 $base64Image");
        // controller.requiredDataForCreateCard['profile'] = base64Image;
        controller.requiredDataForCreateCard['logo'] = base64ImageForLogo;
        // log(controller.requiredDataForCreateCard['profile']);
        // won't have any error now
      });
    }
  }

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

  void addImageForLogo() {
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
                              chooseImageForLogo("Gallery");
                            } else if (data['id'] == 2) {
                              Get.back();
                              chooseImageForLogo("camera");
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

  List colorList = [
    {
      "color_code": "0xFF7c4dff",
    },
    {
      "color_code": "0xFF01efbd",
    },
    {
      "color_code": "0xFF3eb559",
    },
    {
      "color_code": "0xFF7c4dff",
    },
    {
      "color_code": "0xFFf44336",
    },
    {
      "color_code": "0xFF7c4dff",
    },
    {
      "color_code": "0xFF01efbd",
    },
    {
      "color_code": "0xFF3eb559",
    },
    {
      "color_code": "0xFF7c4dff",
    },
    {
      "color_code": "0xFFffc969",
    },
  ];

  String pickerColor = "0xFF7c4dff";

  AllInController controller = Get.find();

  final _formKey = GlobalKey<FormState>();
  createEditCard() {
    controller.requiredDataForCreateCard['color'] = colorToSendBackEnd;
    print(
        "controller.requiredDataForCreateCard $controller.requiredDataForCreateCard");
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      controller.requiredDataForCreateCard['user_id'] = controller.userId;
      print(controller.requiredDataForCreateCard['badge']['Mail']);
      if (controller.requiredDataForCreateCard['badge']['Mail'] == "") {
        CommanDialog.showErrorDialog(description: "Mail Required");
        return;
      } else if (controller.requiredDataForCreateCard['badge']["Mobile"] ==
          "") {
        CommanDialog.showErrorDialog(description: "Mobile Required");
        return;
      }
      controller.requiredDataForCreateCard['badge']['Website'] =
          controller.multiLinkForWebsite;
      controller.requiredDataForCreateCard['badge']['Link'] =
          controller.multiLinkForLink;
      controller.createNewCard(controller.requiredDataForCreateCard);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedImage = null;
  }

  updateCard() {
    if (controller.requiredDataForCreateCard['color'].length == 6) {
      // controller.requiredDataForCreateCard['color'] =
      //     "#${controller.requiredDataForCreateCard['color']}";
      // print("controller ${controller.requiredDataForCreateCard['color']}");
    } else if (controller.requiredDataForCreateCard['color'].length > 6) {
      var removedata = controller.requiredDataForCreateCard['color'].length - 6;
      print("removedata $removedata");

      var data =
          controller.requiredDataForCreateCard['color'].substring(removedata);
      print(data);

      controller.requiredDataForCreateCard['color'] = data;
      print("jj ${controller.requiredDataForCreateCard['color']}");
    }
    if (selectedImage != null) {
      controller.requiredDataForCreateCard['is_profile_image'] = true;
    }
    // controller.requiredDataForCreateCard['color'] = colorToSendBackEnd;
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      controller.requiredDataForCreateCard['user_id'] = controller.userId;
      controller.requiredDataForCreateCard['badge']['Website'] =
          controller.multiLinkForWebsite;
      controller.requiredDataForCreateCard['badge']['Link'] =
          controller.multiLinkForLink;
      controller.editCard(controller.requiredDataForCreateCard);
    }
  }

  final bool _enableLabel = true;
  final bool _portraitOnly = false;
  TextEditingController addItemLinkValue = TextEditingController();

  addLink(dynamic title) {
    print("Title  $title");

    addItemLinkValue.text =
        controller.requiredDataForCreateCard['badge']["$title"];

    Get.dialog(
      Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: addItemLinkValue,
                // initialValue: controller.requiredDataForCreateCard['badge']["$title"],
                decoration: InputDecoration(hintText: "$title "),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    if (Get.isDialogOpen!) Get.back();

                    setState(() {
                      controller.requiredDataForCreateCard['badge']["$title"] =
                          addItemLinkValue.text;
                    });
                    print(" Link Value ${addItemLinkValue.text}");
                    // controller.requiredDataForCreateCard['badge']['Telegram'] =
                    //     "HHHHHHHHHggggg";
                    print(
                        " Updated LInk${controller.requiredDataForCreateCard['badge']["$title"]}");
                    setState(() {});
                  },
                  child: const Text(
                    "Save",
                    // style: AppCommonTheme.titleStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  multiLinkWebsite(dynamic title) {
    print("Title  $title");

    addItemLinkValue.text = "";
    print("Calling multiLinkWebsite");
    // addItemLinkValue.text =
    //     controller.requiredDataForCreateCard['badge']["$title"];
    Get.dialog(
      Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: addItemLinkValue,
                // initialValue: controller.requiredDataForCreateCard['badge']["$title"],
                decoration: InputDecoration(hintText: "$title "),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    print("jfjf ${addItemLinkValue.text}");
                    if (addItemLinkValue.text != "") {
                      if (Get.isDialogOpen!) Get.back();
                      setState(() {
                        print("addItemLinkValue.text");
                        controller.multiLinkForWebsite
                            .add("http://${addItemLinkValue.text}");
                        addItemLinkValue.text = "";
                        // controller.requiredDataForCreateCard['badge']["$title"] =
                        //     addItemLinkValue.text;
                      });
                    } else {
                      if (Get.isDialogOpen!) Get.back();
                    }
                  },
                  child: const Text(
                    "Save",
                    // style: AppCommonTheme.titleStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  multiLinkForLink(dynamic title) {
    addItemLinkValue.text = "";
    print("Calling multiLinkWebsite");
    // addItemLinkValue.text =
    //     controller.requiredDataForCreateCard['badge']["$title"];

    Get.dialog(
      Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: addItemLinkValue,
                // initialValue: controller.requiredDataForCreateCard['badge']["$title"],
                decoration: InputDecoration(hintText: "$title "),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    print("jfjf ${addItemLinkValue.text}");
                    if (addItemLinkValue.text != "") {
                      if (Get.isDialogOpen!) Get.back();
                      setState(() {
                        print("addItemLinkValue.text");
                        controller.multiLinkForLink
                            .add("http://${addItemLinkValue.text}");

                        // controller.requiredDataForCreateCard['badge']["$title"] =
                        //     addItemLinkValue.text;
                      });
                    } else {
                      if (Get.isDialogOpen!) Get.back();
                    }
                  },
                  child: const Text(
                    "Save",
                    // style: AppCommonTheme.titleStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    print("build build");
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
          centerTitle: true,
          title: const Text(
            "New Card",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            widget.type == "edit"
                ? TextButton(
                    onPressed: () {
                      updateCard();
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(fontSize: 18, color: Colors.purple),
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      createEditCard();
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(fontSize: 18, color: Colors.purple),
                    ),
                  ),
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                color: widget.type == "edit"
                                    ? Color(_colorFromHex(controller
                                        .requiredDataForCreateCard["color"]))
                                    : Color(colorValue),
                                height: 360,
                              ),
                            ),
                          ),
                          ClipPath(
                            //upper clippath with less height
                            clipper:
                                WaveClipper(), //set our custom wave clipper.

                            child: InkWell(
                              onTap: addImage,
                              child: Container(
                                width: double.infinity,
                                color: Colors.green,
                                height: 350,
                                alignment: Alignment.center,
                                child: selectedImage != null
                                    ? Image.file(
                                        selectedImage!,
                                        height: double.infinity,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : widget.type == "edit"
                                        ? Image.network(
                                            controller
                                                    .requiredDataForCreateCard[
                                                'profile'],
                                            height: double.infinity,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            'https://image.shutterstock.com/image-vector/thin-line-black-camera-logo-260nw-627479624.jpg',
                                            height: double.infinity,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 10,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () {
                                  addImageForLogo();
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    child: selectedImageForLogo != null
                                        ? Image.file(
                                            selectedImageForLogo!,
                                            height: double.infinity,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          )
                                        : widget.type == "edit"
                                            ? Image.network(
                                                controller
                                                        .requiredDataForCreateCard[
                                                    'logo'],
                                                height: double.infinity,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                'assets/images/add_logo.png',
                                                fit: BoxFit.cover,
                                              ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        titlePadding: const EdgeInsets.all(0),
                                        contentPadding: const EdgeInsets.all(0),
                                        content: SingleChildScrollView(
                                          child: MaterialPicker(
                                            pickerColor: Color(
                                              int.parse(pickerColor),
                                            ),
                                            onColorChanged: (data) {
                                              print("$data fffffff");
                                              print(data.value);
                                              Get.back();
                                              setState(() {
                                                // final hexaNumber =
                                                //     data1.toRadixString(16);

                                                // String oop = "0x$hexaNumber";
                                                // colorValue = int.parse(oop);

                                                // String oop = "0x$hexaNumber";
                                                // colorValue = 0x

                                                final data1 = data.value;
                                                String ooooo =
                                                    "$data".substring(10, 16);
                                                print("fjjsfjs $data1  $ooooo");
                                                colorValue =
                                                    _colorFromHex(ooooo);
                                                print("colorValue $colorValue");
                                              });
                                            },
                                            enableLabel: _enableLabel,
                                            portraitOnly: _portraitOnly,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Colors.yellow,
                                          Colors.red,
                                          Colors.indigo,
                                          Colors.teal,
                                        ],
                                      )),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: List.from(
                                  colorList.map(
                                    (name) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            print(
                                                "object $name  ${colorList[0]['color_code']}");
                                            print(
                                                " Color Code ${name['color_code']}");

                                            String ooooo =
                                                "${name['color_code']}"
                                                    .substring(4, 10);
                                            print("fjjsfjs   $ooooo");

                                            colorValue = _colorFromHex(ooooo);

                                            // colorValue =
                                            //     int.parse(name['color_code']);
                                          });
                                        },
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(
                                                int.parse(name['color_code'])),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue:
                              controller.requiredDataForCreateCard['prefix'],
                          decoration: const InputDecoration(
                            hintText: "Prefix",
                          ),
                          onSaved: (value) {
                            controller.requiredDataForCreateCard['prefix'] =
                                value;
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Prefix Required';
                          //   }
                          //   return null;
                          // },
                        ),
                        TextFormField(
                          initialValue: controller
                              .requiredDataForCreateCard['first_name'],
                          decoration: const InputDecoration(
                            hintText: "First Name",
                          ),
                          onSaved: (value) {
                            controller.requiredDataForCreateCard['first_name'] =
                                value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'First Name Required';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          initialValue: controller
                              .requiredDataForCreateCard['middle_name'],
                          decoration: const InputDecoration(
                            hintText: "Middle Name",
                          ),
                          onSaved: (value) {
                            controller
                                    .requiredDataForCreateCard['middle_name'] =
                                value;
                          },
                        ),
                        TextFormField(
                          initialValue:
                              controller.requiredDataForCreateCard['last_name'],
                          decoration: const InputDecoration(
                            hintText: "Last Name",
                          ),
                          onSaved: (value) {
                            controller.requiredDataForCreateCard['last_name'] =
                                value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Last Name Required';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          initialValue:
                              controller.requiredDataForCreateCard['suffix'],
                          decoration: const InputDecoration(
                            hintText: "Suffix",
                          ),
                          onSaved: (value) {
                            controller.requiredDataForCreateCard['suffix'] =
                                value;
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Suffix Required';
                          //   }
                          //   return null;
                          // },
                        ),
                        TextFormField(
                          initialValue: controller
                              .requiredDataForCreateCard['accreditations'],
                          decoration: const InputDecoration(
                            hintText: "Accreditations",
                          ),
                          onSaved: (value) {
                            controller.requiredDataForCreateCard[
                                'accreditations'] = value;
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Accreditations Required';
                          //   }
                          //   return null;
                          // },
                        ),
                        TextFormField(
                          initialValue: controller
                              .requiredDataForCreateCard['preferred_name'],
                          decoration: const InputDecoration(
                            hintText: "Preferred Name",
                          ),
                          onSaved: (value) {
                            controller.requiredDataForCreateCard[
                                'preferred_name'] = value;
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Preferred Name Required';
                          //   }
                          //   return null;
                          // },
                        ),
                        // TextFormField(
                        //   initialValue: controller
                        //       .requiredDataForCreateCard['maiden_name'],
                        //   decoration: const InputDecoration(
                        //     hintText: "Maiden Name",
                        //   ),
                        //   onSaved: (value) {
                        //     controller
                        //             .requiredDataForCreateCard['maiden_name'] =
                        //         value;
                        //   },validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Maiden Name Required';
                        //     }
                        //     return null;
                        //   },

                        // ),
                        TextFormField(
                          initialValue:
                              controller.requiredDataForCreateCard['pronouns'],
                          decoration: const InputDecoration(
                            hintText: "Pronouns",
                          ),
                          onSaved: (value) {
                            controller.requiredDataForCreateCard['pronouns'] =
                                value;
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Pronouns Required';
                          //   }
                          //   return null;
                          // },
                        ),
                        TextFormField(
                          initialValue:
                              controller.requiredDataForCreateCard['title'],
                          decoration: const InputDecoration(
                            hintText: "Title",
                          ),
                          onSaved: (value) {
                            controller.requiredDataForCreateCard['title'] =
                                value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Title Required';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          initialValue: controller
                              .requiredDataForCreateCard['department'],
                          decoration: const InputDecoration(
                            hintText: "Department",
                          ),
                          onSaved: (value) {
                            controller.requiredDataForCreateCard['department'] =
                                value;
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Department Required';
                          //   }
                          //   return null;
                          // },
                        ),
                        TextFormField(
                          initialValue:
                              controller.requiredDataForCreateCard['company'],
                          decoration: const InputDecoration(
                            hintText: "Company",
                          ),
                          onSaved: (value) {
                            controller.requiredDataForCreateCard['company'] =
                                value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Company Required';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          initialValue:
                              controller.requiredDataForCreateCard['headline'],
                          decoration: const InputDecoration(
                            hintText: "Headline",
                          ),
                          onSaved: (value) {
                            controller.requiredDataForCreateCard['headline'] =
                                value;
                          },

                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Headline Required';
                          //   }
                          //   return null;
                          // },
                        ),

                        ...controller.multiLinkForWebsite
                            .asMap()
                            .map((i, element) => MapEntry(
                                i,
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          "assets/images/web.png",
                                          width: 20,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(child: Text(element)),
                                        IconButton(
                                          onPressed: () {
                                            setState(
                                              () {
                                                controller.multiLinkForWebsite
                                                    .removeAt(i);
                                              },
                                            );
                                          },
                                          icon: const Icon(Icons.highlight_off),
                                        )
                                      ],
                                    ),
                                  ),
                                )))
                            .values
                            .toList(),
                        ...controller.multiLinkForLink
                            .asMap()
                            .map((i, element) => MapEntry(
                                i,
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          "assets/images/link.png",
                                          width: 20,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(child: Text(element)),
                                        IconButton(
                                          onPressed: () {
                                            setState(
                                              () {
                                                controller.multiLinkForLink
                                                    .removeAt(i);
                                              },
                                            );
                                          },
                                          icon: const Icon(Icons.highlight_off),
                                        )
                                      ],
                                    ),
                                  ),
                                )))
                            .values
                            .toList(),
                        controller.requiredDataForCreateCard['badge']['Mail'] !=
                                ""
                            ? TextFormField(
                                initialValue: controller
                                    .requiredDataForCreateCard['badge']['Mail'],
                                decoration: const InputDecoration(
                                  hintText: "Mail",
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    controller
                                            .requiredDataForCreateCard['badge']
                                        ['Mail'] = value;
                                  });
                                },
                              )
                            : const SizedBox(),
                        controller.requiredDataForCreateCard['badge']
                                    ['Mobile'] !=
                                ""
                            ? TextFormField(
                                initialValue: controller
                                        .requiredDataForCreateCard['badge']
                                    ['Mobile'],
                                decoration: const InputDecoration(
                                  hintText: "Mobile",
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    controller
                                            .requiredDataForCreateCard['badge']
                                        ['Mobile'] = value;
                                  });
                                },
                              )
                            : const SizedBox(),
                        controller.requiredDataForCreateCard['badge']
                                    ['Location'] !=
                                ""
                            ? TextFormField(
                                initialValue: controller
                                        .requiredDataForCreateCard['badge']
                                    ['Location'],
                                decoration: const InputDecoration(
                                  hintText: "Location",
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    controller
                                            .requiredDataForCreateCard['badge']
                                        ['Location'] = value;
                                  });
                                },
                              )
                            : controller.requiredDataForCreateCard['badge']
                                        ['Facebook'] !=
                                    ""
                                ? TextFormField(
                                    initialValue: controller
                                            .requiredDataForCreateCard['badge']
                                        ['Facebook'],
                                    decoration: const InputDecoration(
                                      hintText: "Facebook",
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        controller.requiredDataForCreateCard[
                                            'badge']['Facebook'] = value;
                                      });
                                    },
                                  )
                                : const SizedBox(),
                        controller.requiredDataForCreateCard['badge']
                                    ['Instagram'] !=
                                ""
                            ? TextFormField(
                                initialValue: controller
                                        .requiredDataForCreateCard['badge']
                                    ['Instagram'],
                                decoration: const InputDecoration(
                                  hintText: "Instagram",
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    controller
                                            .requiredDataForCreateCard['badge']
                                        ['Instagram'] = value;
                                  });
                                },
                              )
                            : const SizedBox(),
                        controller.requiredDataForCreateCard['badge']
                                    ['Whatsapp'] !=
                                ""
                            ? TextFormField(
                                initialValue: controller
                                        .requiredDataForCreateCard['badge']
                                    ['Whatsapp'],
                                decoration: const InputDecoration(
                                  hintText: "Whatsapp",
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    controller
                                            .requiredDataForCreateCard['badge']
                                        ['Whatsapp'] = value;
                                  });
                                },
                              )
                            : const SizedBox(),
                        controller.requiredDataForCreateCard['badge']
                                    ['Twitter'] !=
                                ""
                            ? TextFormField(
                                initialValue: controller
                                        .requiredDataForCreateCard['badge']
                                    ['Twitter'],
                                decoration: const InputDecoration(
                                  hintText: "Twitter",
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    controller
                                            .requiredDataForCreateCard['badge']
                                        ['Twitter'] = value;
                                  });
                                },
                              )
                            : const SizedBox(),
                        controller.requiredDataForCreateCard['badge']
                                    ['Linkedin'] !=
                                ""
                            ? TextFormField(
                                initialValue: controller
                                        .requiredDataForCreateCard['badge']
                                    ['Linkedin'],
                                decoration: const InputDecoration(
                                  hintText: "Linkedin",
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    controller
                                            .requiredDataForCreateCard['badge']
                                        ['Linkedin'] = value;
                                  });
                                },
                              )
                            : const SizedBox(),
                        controller.requiredDataForCreateCard['badge']
                                    ['Youtube'] !=
                                ""
                            ? TextFormField(
                                initialValue: controller
                                        .requiredDataForCreateCard['badge']
                                    ['Youtube'],
                                decoration: const InputDecoration(
                                  hintText: "Youtube",
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    controller
                                            .requiredDataForCreateCard['badge']
                                        ['Youtube'] = value;
                                  });
                                },
                              )
                            : const SizedBox(),
                        controller.requiredDataForCreateCard['badge']
                                    ['Telegram'] !=
                                ""
                            ? TextFormField(
                                initialValue: controller
                                        .requiredDataForCreateCard['badge']
                                    ['Telegram'],
                                decoration: const InputDecoration(
                                  hintText: "Telegram",
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    controller
                                            .requiredDataForCreateCard['badge']
                                        ['Telegram'] = value;
                                  });
                                },
                              )
                            : const SizedBox(),
                        controller.requiredDataForCreateCard['badge']
                                    ['Skype'] !=
                                ""
                            ? TextFormField(
                                initialValue: controller
                                        .requiredDataForCreateCard['badge']
                                    ['Skype'],
                                decoration: const InputDecoration(
                                  hintText: "Skype",
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    controller
                                            .requiredDataForCreateCard['badge']
                                        ['Skype'] = value;
                                  });
                                },
                              )
                            : const SizedBox(),
                        controller.requiredDataForCreateCard['badge']
                                    ['Paypal'] !=
                                ""
                            ? TextFormField(
                                initialValue: controller
                                        .requiredDataForCreateCard['badge']
                                    ['Paypal'],
                                decoration: const InputDecoration(
                                  hintText: "Paypal",
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    controller
                                            .requiredDataForCreateCard['badge']
                                        ['Paypal'] = value;
                                  });
                                },
                              )
                            : const SizedBox(),
                        controller.requiredDataForCreateCard['badge']
                                    ['Wechat'] !=
                                ""
                            ? TextFormField(
                                initialValue: controller
                                        .requiredDataForCreateCard['badge']
                                    ['Wechat'],
                                decoration: const InputDecoration(
                                  hintText: "Wechat",
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    controller
                                            .requiredDataForCreateCard['badge']
                                        ['Wechat'] = value;
                                  });
                                },
                              )
                            : const SizedBox(),
                        controller.requiredDataForCreateCard['badge']
                                    ['Calendly'] !=
                                ""
                            ? TextFormField(
                                initialValue: controller
                                        .requiredDataForCreateCard['badge']
                                    ['Calendly'],
                                decoration: const InputDecoration(
                                  hintText: "Calendly",
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    controller
                                            .requiredDataForCreateCard['badge']
                                        ['Calendly'] = value;
                                  });
                                },
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  color: const Color(0xFFE4DECE),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.add,
                              size: 30,
                            ),
                            Text(
                              "Add Item",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                addLink('Mail');
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/email.png",
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Email"),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                addLink('Mobile');
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/phone.png",
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Mobile"),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                addLink('Location');
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/location.png",
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Location"),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                multiLinkWebsite('Website');
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/web.png",
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Website"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                multiLinkForLink('Link');
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/link.png",
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Link"),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                addLink('Facebook');
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/facebook.png",
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Facebook"),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                addLink('Whatsapp');
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/whatsapp.png",
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Whatsapp"),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                addLink('Instagram');
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/instagram.png",
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Instagram"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                addLink('Twitter');
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/twitter.png",
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text("Twitter"),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                addLink('Linkedin');
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/linkedin.png",
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Linkedin"),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                addLink('Youtube');
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/youtube.png",
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Youtube"),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                addLink('Telegram');
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/telegram.png",
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Telegram"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                addLink('Skype');
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/skype.png",
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Skype"),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                addLink('Paypal');
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/paypal.png",
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Paypal"),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                addLink('Wechat');
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/wechat.png",
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text("Wechat"),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                addLink('Calendly');
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/cnd.png",
                                    width: 30,
                                  ),
                                  const Text("Calendly"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
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
