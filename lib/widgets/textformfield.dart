import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final bool? disabled;
  final String? Function(String?) validator;
  const CustomTextFormField(
      {Key? key,
      this.controller,
      required this.label,
      required this.validator,
      this.disabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: disabled == true ? false : true,
      decoration: InputDecoration(
        label: Text(label),
        filled: disabled,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
