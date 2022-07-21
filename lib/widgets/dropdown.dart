import 'package:flutter/material.dart';

class CustomDropDownButton<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final Function(T?) onChanged;
  final String hint;
  final String? Function(T?) validator;
  const CustomDropDownButton(
      {Key? key,
      this.value,
      required this.items,
      required this.onChanged,
      required this.hint,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        value: value,
        hint: Text(hint),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10), border: OutlineInputBorder()),
        isExpanded: true,
        items: items,
        validator: validator,
        onChanged: onChanged);
  }
}
