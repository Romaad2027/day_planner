import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final bool isEditMode;
  final String? initialValue;
  final String? hintText;
  final TextEditingController? controller;

  const ProfileTextField({
    this.initialValue,
    this.isEditMode = false,
    this.hintText,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      decoration: InputDecoration(hintText: hintText, border: OutlineInputBorder()),
      enabled: isEditMode,
    );
  }
}
