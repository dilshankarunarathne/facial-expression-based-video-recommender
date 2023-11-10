import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
  CircularIndicator({
    required this.isVisible,
    super.key,
  });
  bool isVisible;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: const CircularProgressIndicator(),
    );
  }
}
