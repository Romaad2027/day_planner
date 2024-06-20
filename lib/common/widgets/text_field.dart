import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final bool isEditMode;
  final String? initialValue;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CommonTextField({
    this.initialValue,
    this.isEditMode = true,
    this.hintText,
    this.controller,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      decoration: InputDecoration(
        label: Text(hintText ?? ''),
        border: const OutlineInputBorder(),
      ),
      enabled: isEditMode,
      validator: validator,
    );
  }
}
