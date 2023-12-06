import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class GenerateQRCodeScreen extends StatelessWidget {
  final String qrCodeUrl;
  final int color;
  const GenerateQRCodeScreen(
      {Key? key, required this.qrCodeUrl, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              child: QrImage(
                  // eyeStyle: const QrEyeStyle(
                  //   eyeShape: QrEyeShape.circle,
                  //   color: Colors.black,
                  // ),
                  // dataModuleStyle: const QrDataModuleStyle(
                  //   dataModuleShape: QrDataModuleShape.circle,
                  //   color: Colors.black,
                  // ),
                  backgroundColor: Colors.white,
                  data: qrCodeUrl,
                  version: QrVersions.auto,
                  size: 300,
                  gapless: false,
                  //You can use image here, Note this image should be of type File
                  embeddedImage: const AssetImage(
                    "assets/images/Untitled-2.png",
                  ),
                  embeddedImageStyle: QrEmbeddedImageStyle(
                    size: const Size(40, 40),
                  )
                  // ),
                  ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Point your camera at the QR code.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 50,
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
          ),
          onPressed: () {
            Share.share(qrCodeUrl, subject: 'ConnectAna Card');
          },
          icon: Icon(
            Icons.share,
            color: Color(color),
          ),
          label: Text(
            "SEND LINK",
            style: TextStyle(color: Color(color)),
          ),
        ),
      ],
    );
  }
}
