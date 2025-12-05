import 'package:flutter/material.dart';

class TextFormInput extends StatelessWidget {
  final TextEditingController nameController;
  final String label;
  final String placeHolder;
  final String? Function(String?) validate;
  const TextFormInput({
    super.key,
    required this.nameController,
    required this.label,
    required this.placeHolder,
    required this.validate,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      validator: validate,
      decoration: InputDecoration(
          label: Text(label),
          hintText: placeHolder,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.circular(8),
          )),
    );
  }
}
