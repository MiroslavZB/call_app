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
  Uint8List? decodedImage;
  if (image != null) {
    try {
      decodedImage = base64Decode(image);
    } catch (_) {}
  }
  return Container(
    height: size,
    width: size,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: fillColor,
    ),
    child: decodedImage != null
        ? Image.memory(
            decodedImage,
            height: size,
            width: size,
            fit: BoxFit.cover,
          )
        : Center(
            child: name?.isNotEmpty != true
                ? Icon(
                    Icons.account_circle_rounded,
                    color: Colors.grey[50],
                    size: extraBigIconSize,
                  )
                : Text(
                    name!.substring(0, 1).toUpperCase(),
                    style: styleH1.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
          ),
  );
}
