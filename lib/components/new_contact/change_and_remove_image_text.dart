import 'package:call_app/resources/constants.dart';
import 'package:flutter/material.dart';

Widget changeAndRemoveImageText() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.edit_outlined,
          color: darkAccentColor,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Text(
            'Change',
            style: styleH4.copyWith(color: darkAccentColor),
          ),
        ),
        const Icon(
          Icons.delete_forever_outlined,
          color: darkAccentColor,
        ),
        Text(
          'Remove',
          style: styleH4.copyWith(color: darkAccentColor),
        ),
      ],
    ),
  );
}
