import 'package:call_app/resources/constants.dart';
import 'package:flutter/material.dart';

Widget addImageText() {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 40),
    child: Text(
      'Add picture',
      style: styleH5.copyWith(
        color: darkAccentColor,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
