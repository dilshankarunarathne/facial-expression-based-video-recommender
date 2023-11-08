import 'package:flutter/material.dart';
import 'package:video_filter/custom-widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.size,
      required this.ontap,
      required this.text,
      required this.buttonColor,
      required this.textColor});

  final Size size;
  VoidCallback ontap;
  Color buttonColor;
  Color textColor;
  String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          width: size.width * 0.8,
          height: 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: buttonColor),
          child: Center(
            child: CustomPoppinsText(
                color: textColor,
                fsize: 20,
                fweight: FontWeight.w500,
                text: text),
          )),
    );
  }
}
