import 'package:flutter/material.dart';

class TextfieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool ispass;
  final String hintText;
  final IconData icon;

  const TextfieldInput({
    super.key,
    required this.textEditingController,
    this.ispass = false,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: TextField(
          obscureText: ispass,
          controller: textEditingController,
          decoration: InputDecoration(
            labelText: "Email",
            hintText: hintText,
            contentPadding: EdgeInsets.all(10),
            prefixIcon: Icon(icon),
            prefixIconColor: const Color.fromARGB(255, 0, 0, 0),
            border: InputBorder.none,
            filled: true,
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(30)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.cyanAccent),
                borderRadius: BorderRadius.circular(30)),
          )),
    );
  }
}
