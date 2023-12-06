import 'package:connectana/view/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String buttonType;
  final String buttonText;
  final String? buttonIconImage;
  final Function() onPressed;
  final Color buttonbgColor;
  final Color buttonTextColor;

  const AppButton({
    Key? key,
    required this.buttonType,
    required this.buttonText,
    required this.onPressed,
    required this.buttonbgColor,
    this.buttonIconImage,
    required this.buttonTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buttonType == "simpleButton"
        ? ElevatedButton(
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: TextStyle(
                  color: buttonTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppCommonTheme.buttonRadious),
              ),
              primary: buttonbgColor,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            ),
          )
        : ElevatedButton.icon(
            onPressed: onPressed,
            icon: Image.asset(
              "$buttonIconImage",
              width: 30,
            ),
            label: Text(
              buttonText,
              style: TextStyle(
                  color: buttonTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 1,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Colors.black),
                borderRadius:
                    BorderRadius.circular(AppCommonTheme.buttonRadious),
              ),
              primary: buttonbgColor,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            ),
          );
  }
}
