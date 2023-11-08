import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPoppinsText extends StatelessWidget {
  CustomPoppinsText(
      {super.key,
      required this.text,
      required this.color,
      required this.fsize,
      required this.fweight});

  String text;
  Color color;
  double fsize;
  FontWeight fweight;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.poppins(
            color: color, fontSize: fsize, fontWeight: fweight));
  }
}
