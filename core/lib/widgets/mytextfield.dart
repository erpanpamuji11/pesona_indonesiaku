import 'package:flutter/material.dart';

Widget buildTextField(TextEditingController controller, String labelText,
    String hintText, TextInputType inputType) {
  return TextFormField(
    controller: controller,
    keyboardType: inputType,
    style: const TextStyle(fontSize: 17),
    validator: (value) {
      if (value!.isEmpty) {
        return "it is empty";
      } else {
        return null;
      }
    },
    decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 18),
        labelStyle: const TextStyle(color: Colors.grey),
        // prefix: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
  );
}
