import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    required this.label,
    required this.picon,
    required this.controller,
    required this.validate,
    this.keyType = TextInputType.text,
    this.security = false,
    this.disable=false,
  });
  Icon picon;
  String label;
  TextInputType keyType;
  bool security = false;
  bool disable;
  TextEditingController controller;
  final String? Function(String?)? validate;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: security,
      keyboardType: keyType,
      readOnly: disable,
      decoration: InputDecoration(
        labelText: label,
        fillColor: Colors.white,
        prefixIcon: picon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      validator: validate,
    );
  }
}
