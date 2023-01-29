import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:call_app/resources/constants.dart';
import 'package:flutter/material.dart';

Widget contactImage({
  required String firstName,
  String? image,
  double size = contactImageSize,
}) {
  final MaterialColor fillColor = Colors.primaries[Random().nextInt(Colors.primaries.length - 1)];
  if (image != null) {
    Uint8List decodedImage;
    try {
      decodedImage = base64Decode(image);
    } catch (e) {
      return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: fillColor,
        ),
      );
    }
    return Image.memory(
      decodedImage,
      height: size,
      width: size,
    );
  }
  return Container(
    padding: const EdgeInsets.all(10),
    height: size,
    width: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: fillColor,
    ),
    child: Center(
      child: Text(
        firstName.substring(0, 1).toUpperCase(),
        style: const TextStyle(
          fontSize: sizeH1,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    ),
  );
}
