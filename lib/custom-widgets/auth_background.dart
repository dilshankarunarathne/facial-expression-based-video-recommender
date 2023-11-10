import 'package:flutter/material.dart';
import 'package:video_filter/custom-widgets/custom_text.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground(
      {super.key,
      required this.size,
      required this.content,
      required this.text1,
      required this.text2});

  final Size size;
  final Widget content;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Container(
            height: size.height * 0.4,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: CustomPoppinsText(
                      text: text1,
                      color: Colors.white,
                      fsize: 25,
                      fweight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: CustomPoppinsText(
                      text: text2,
                      color: Colors.white,
                      fsize: 15,
                      fweight: FontWeight.w300),
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.33,
            child: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), // Adjust the radius as needed
                  topRight: Radius.circular(12), // Adjust the radius as needed
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: content,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
