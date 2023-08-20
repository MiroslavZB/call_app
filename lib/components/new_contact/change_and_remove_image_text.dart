import 'package:call_app/functions/add_image.dart';
import 'package:call_app/resources/constants.dart';
import 'package:call_app/state/image_picker_state.dart';
import 'package:flutter/material.dart';

Widget changeAndRemoveImageText(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: InkWell(
            onTap: () => addImage(context),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.edit_outlined,
                    color: darkAccentColor,
                  ),
                ),
                Text(
                  'Change',
                  style: TextStyle(
                    color: darkAccentColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => BlocProvider.of<ImagePickerState>(context).set(''),
          child: const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.delete_forever_outlined,
                  color: darkAccentColor,
                ),
              ),
              Text(
                'Remove',
                style: TextStyle(
                  color: darkAccentColor,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
