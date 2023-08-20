import 'package:call_app/resources/constants.dart';
import 'package:flutter/material.dart';

Widget backspaceButton(TextEditingController callController) {
  return IconButton(
    onPressed: () {
      if (callController.text.isEmpty) return;
      callController.text = callController.text.substring(0, callController.text.length - 1);
    },
    color: darkAccentColor,
    icon: const Icon(
      Icons.backspace,
      size: 35,
    ),
  );
}
