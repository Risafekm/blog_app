// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ButtonLogout extends StatelessWidget {
  String text;
  VoidCallback onPressed;
  ButtonLogout({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            fixedSize: const MaterialStatePropertyAll(
              Size(250, 50),
            ),
            backgroundColor: const MaterialStatePropertyAll(Colors.blue),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            )),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
