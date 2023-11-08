import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();

  TextEditingController get nameController => _nameController;

  void setUserName(String name) {
    _nameController.text = name;
    notifyListeners();
  }
}
