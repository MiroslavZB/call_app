import 'package:call_app/resources/constants.dart';
import 'package:flutter/material.dart';

Widget addImageBox(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Container(
      height: MediaQuery.of(context).size.width / 3,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: lightAccentColor,
      ),
      child: const Center(
        child: Icon(
          Icons.image_outlined,
          size: extraBigIconSize,
        ),
      ),
    ),
  );
}
