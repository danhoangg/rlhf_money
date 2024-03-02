import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() onPressed;
  const MyButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      focusNode: FocusNode(
        canRequestFocus: false,
      ),
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color.fromARGB(255, 119, 141, 169),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      icon: Icon(
        icon,
        color: const Color.fromARGB(255, 27, 38, 59),
      ),
      label: Text(
        text,
        style: const TextStyle(
          color: Color.fromARGB(255, 27, 38, 59),
        ),
      ),
    );
  }
}
