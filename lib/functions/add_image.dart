import 'package:call_app/components/image_picker_button.dart';
import 'package:call_app/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void addImage(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(smallBorderRadius),
        ),
        title: const Text(
          'Add image from:',
          style: styleH3,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            imagePickerWidget(
              context,
              source: ImageSource.gallery,
              iconData: Icons.image,
              text: 'Gallery',
            ),
            imagePickerWidget(
              context,
              source: ImageSource.camera,
              iconData: Icons.camera,
              text: 'Camera',
            ),
          ],
        ),
      );
    },
  );
}
