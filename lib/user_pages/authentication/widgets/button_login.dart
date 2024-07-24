// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  String text;
  ButtonLogin({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            fixedSize: const MaterialStatePropertyAll(
              Size(400, 50),
            ),
            backgroundColor: const MaterialStatePropertyAll(Colors.purple),
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
