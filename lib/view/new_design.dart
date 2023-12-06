import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class NewCardDesign extends StatelessWidget {
  const NewCardDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.8;
    final double itemWidth = size.width / 2;
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Card Design"),
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
          controller: ScrollController(keepScrollOffset: false),
          shrinkWrap: true,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                padding: const EdgeInsets.all(1),
                child: Stack(
                  children: <Widget>[
                    //stack overlaps widgets
                    ClipPath(
                      clipper: WaveClipper(), //set our custom wave clipper
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        child: Container(
                          color: Colors.red,
                          height: 200,
                        ),
                      ),
                    ),
                    ClipPath(
                      //upper clippath with less height
                      clipper: WaveClipper(), //set our custom wave clipper.
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
                              "https://image.shutterstock.com/image-photo/ancient-temple-ruins-gadi-sagar-260nw-786126286.jpg",
                              errorBuilder: ((context, error, stackTrace) {
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

                    const Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Text(
                              "BL Kumawat",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ) //Your widget here,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )

        // SizedBox(
        //   height: 290,
        //   width: 300,
        //   child: Card(
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(20.0),
        //       ),
        //       child: Column(
        //         children: [
        //           Stack(
        //             children: <Widget>[
        //               //stack overlaps widgets
        //               ClipPath(
        //                 clipper: WaveClipper(), //set our custom wave clipper
        //                 child: ClipRRect(
        //                   borderRadius: const BorderRadius.only(
        //                     topLeft: Radius.circular(20.0),
        //                     topRight: Radius.circular(20.0),
        //                   ),
        //                   child: Container(
        //                     color: Colors.red,
        //                     height: 200,
        //                   ),
        //                 ),
        //               ),
        //               ClipPath(
        //                 //upper clippath with less height
        //                 clipper: WaveClipper(), //set our custom wave clipper.
        //                 child: ClipRRect(
        //                   borderRadius: const BorderRadius.only(
        //                     topLeft: Radius.circular(20.0),
        //                     topRight: Radius.circular(20.0),
        //                   ),
        //                   child: Container(
        //                     width: double.infinity,
        //                     // color: Colors.green,
        //                     height: 190,
        //                     alignment: Alignment.center,
        //                     child: ClipRRect(
        //                       borderRadius: const BorderRadius.only(
        //                         topLeft: Radius.circular(20.0),
        //                         topRight: Radius.circular(20.0),
        //                       ),
        //                       child: Image.network(
        //                         "https://image.shutterstock.com/image-photo/ancient-temple-ruins-gadi-sagar-260nw-786126286.jpg",
        //                         errorBuilder: ((context, error, stackTrace) {
        //                           return const Text(
        //                             "Image Error",
        //                             style: TextStyle(
        //                                 color: Colors.red,
        //                                 fontSize: 18,
        //                                 fontWeight: FontWeight.bold),
        //                           );
        //                         }),
        //                         fit: BoxFit.cover,
        //                         width: double.infinity,
        //                         height: 190,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //           const SizedBox(
        //             height: 60,
        //             child: Text(
        //               "ABCD",
        //               style: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           )
        //         ],
        //       )),
        // ),
        );
  }
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
