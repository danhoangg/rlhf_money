import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 119, 141, 169)),
          focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 65, 90, 119), width: 2),
          ),
          floatingLabelStyle: const TextStyle(
            color: Color.fromARGB(255, 65, 90, 119),
          ),
        ),
        obscureText: obscureText,
        controller: controller,
      ),
    );
  }
}
