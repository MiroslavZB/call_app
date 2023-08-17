import 'dart:convert';
import 'dart:typed_data';

import 'package:call_app/resources/constants.dart';
import 'package:flutter/material.dart';

Widget contactImage({
  required String? name,
  required int? fillColorHex,
  String? image,
  double size = contactImageSize,
}) {
  final Color fillColor = fillColorHex == null ? Colors.grey : Color(fillColorHex);
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
    height: size,
    width: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: fillColor,
    ),
    child: Center(
      child: name == null
          ? Icon(
              Icons.account_circle_rounded,
              color: Colors.grey[50],
              size: extraBigIconSize,
            )
          : Text(
              name.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                fontSize: sizeH1,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
    ),
  );
}
