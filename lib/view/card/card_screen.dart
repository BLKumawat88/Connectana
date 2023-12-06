import 'dart:convert';

import 'package:connectana/controller/all_in_controller.dart';
import 'package:connectana/view/card/view_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../qrcode/qrcode_screen.dart';

class CardScreen extends StatelessWidget {
  CardScreen({Key? key}) : super(key: key);

  final AllInController controller = Get.find();
  viewCard(data) {
    Get.to(ViewCardScreen(
      cardDetails: data,
    ));
  }

  int _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return int.parse('FF$hexCode', radix: 16);
    // }
  }

  Widget getImagenBase64(String imagen) {
    const Base64Codec base64 = Base64Codec();
    // if (_imageBase64 == null) return new Container();
    final bytes = base64.decode(imagen);
    return Image.memory(
      bytes,
      fit: BoxFit.cover,
      width: double.infinity,
      height: 190,
    );
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarColor: Color(AppCommonTheme.appBGColor),
    //   ),
    // );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // controller.allCardData.clear();
      controller.getAllCardList();
    });

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.8;
    final double itemWidth = size.width / 2;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: GetBuilder<AllInController>(
            builder: (controller) {
              return GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                controller: ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                children: <Widget>[
                  ...controller.allCardData.map((data) {
                    return InkWell(
                      onTap: () {
                        viewCard(data);
                      },
                      onDoubleTap: () {
                        controller.sendCardOnMobile['card_id'] = data['id'];
                        controller.sendCardOnMail['card_id'] = data['id'];
                        Get.to(
                          () => QrCodeScreen(
                              qrCodeUrl: data['NFC_link'],
                              color: _colorFromHex(data['color'])),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          child: Stack(
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
                                    color: Color(_colorFromHex(data['color'])),
                                    height: 200,
                                  ),
                                ),
                              ),
                              ClipPath(
                                //upper clippath with less height
                                clipper:
                                    WaveClipper(), //set our custom wave clipper.
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    // color: Colors.green,
                                    height: 190,
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                      ),
                                      child: Image.network(
                                        data['profile'],
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
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 190,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: Text(
                                      data["full_name"],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ) //Your widget here,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
                ],
              );

              // Column(
              //   children: [
              //     ...controller.allCardData.map((data) {
              //       return Padding(
              //         padding: const EdgeInsets.symmetric(vertical: 5),
              //         child: SizedBox(
              //           width: 220,
              //           child: InkWell(
              //             onTap: () {
              //               viewCard(data);
              //             },
              //             child: Card(
              //               elevation: 5,
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(20.0),
              //               ),
              //               child: Column(
              //                 children: [
              //                   Stack(
              //                     children: <Widget>[
              //                       //stack overlaps widgets
              //                       ClipPath(
              //                         clipper:
              //                             WaveClipper(), //set our custom wave clipper
              //                         child: ClipRRect(
              //                           borderRadius: const BorderRadius.only(
              //                             topLeft: Radius.circular(20.0),
              //                             topRight: Radius.circular(20.0),
              //                           ),
              //                           child: Container(
              //                             color:
              //                                 Color(_colorFromHex(data['color'])
              //                                     // int.parse(
              //                                     //   data['color'],
              //                                     // ),
              //                                     ),
              //                             height: 200,
              //                           ),
              //                         ),
              //                       ),
              //                       ClipPath(
              //                         //upper clippath with less height
              //                         clipper:
              //                             WaveClipper(), //set our custom wave clipper.
              //                         child: ClipRRect(
              //                           borderRadius: const BorderRadius.only(
              //                             topLeft: Radius.circular(20.0),
              //                             topRight: Radius.circular(20.0),
              //                           ),
              //                           child: Container(
              //                             width: double.infinity,
              //                             // color: Colors.green,
              //                             height: 190,
              //                             alignment: Alignment.center,
              //                             child: ClipRRect(
              //                               borderRadius:
              //                                   const BorderRadius.only(
              //                                 topLeft: Radius.circular(20.0),
              //                                 topRight: Radius.circular(20.0),
              //                               ),
              //                               child: Image.network(
              //                                 data['profile'],
              //                                 errorBuilder: ((context, error,
              //                                     stackTrace) {
              //                                   return const Text(
              //                                     "Image Error",
              //                                     style: TextStyle(
              //                                         color: Colors.red,
              //                                         fontSize: 18,
              //                                         fontWeight:
              //                                             FontWeight.bold),
              //                                   );
              //                                 }),
              //                                 fit: BoxFit.cover,
              //                                 width: double.infinity,
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   SizedBox(
              //                     height: 60,
              //                     child: Text(
              //                       data["full_name"],
              //                       style: const TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       );
              //     }).toList(),
              //     const SizedBox(
              //       height: 50,
              //     ),
              //   ],
              // );
            },
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
    // path.lineTo(
    //     0, size.height); //start path with this if you are making at bottom

    // var firstStart = Offset(size.width / 5, size.height);
    // //fist point of quadratic bezier curve
    // var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    // //second point of quadratic bezier curve
    // path.quadraticBezierTo(
    //     firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    // var secondStart =
    //     Offset(size.width - (size.width / 3.24), size.height - 105);
    // //third point of quadratic bezier curve
    // var secondEnd = Offset(size.width, size.height - 10);
    // //fourth point of quadratic bezier curve
    // path.quadraticBezierTo(
    //     secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    // path.lineTo(
    //     size.width, 0); //end with this path if you are making wave at bottom
    // path.close();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
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
