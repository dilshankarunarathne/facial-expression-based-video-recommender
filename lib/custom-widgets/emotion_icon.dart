import 'package:flutter/material.dart';

class EmotionIcon extends StatelessWidget {
  EmotionIcon({super.key, required this.output});
  String output;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 75,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(_emoji()), fit: BoxFit.cover)),
    );
  }

  String _emoji() {
    if (output == "Happy Mood") {
      return "lib/assets/happy.png";
    } else if (output == "Sad Mood") {
      return "lib/assets/sad.png";
    } else {
      return "lib/assets/angry.png";
    }
  }
}
