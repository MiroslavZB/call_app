import 'package:call_app/resources/constants.dart';
import 'package:flutter/material.dart';

Widget backspaceButton(TextEditingController callController, [bool isActive = true]) {
  return IconButton(
    onPressed: isActive && callController.text.isNotEmpty
        ? () => callController.text = callController.text.substring(0, callController.text.length - 1)
        : null,
    color: darkAccentColor,
    icon: const Icon(
      Icons.backspace,
      size: 35,
    ),
  );
}
