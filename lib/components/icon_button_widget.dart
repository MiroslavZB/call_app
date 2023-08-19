import 'package:call_app/resources/constants.dart';
import 'package:flutter/material.dart';

Widget iconButtonWidget({
  required IconData icon,
  required String text,
  required Function() onPressed,
}) {
  return Container(
    clipBehavior: Clip.hardEdge,
    padding: const EdgeInsets.all(5),
    decoration: const BoxDecoration(shape: BoxShape.circle),
    child: TextButton(
      onPressed: onPressed,
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Icon(icon, size: bigIconSize, color: darkAccentColor),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: sizeH4, color: darkAccentColor),
          ),
        ],
      ),
    ),
  );
}
