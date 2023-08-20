import 'package:call_app/resources/constants.dart';
import 'package:call_app/state/shared_bool_state.dart';
import 'package:flutter/material.dart';

Widget moreFieldsButton(BuildContext context, bool state) {
  return InkWell(
    onTap: () => BlocProvider.of<SharedBoolState>(context).flip(),
    child: Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.person_outline_rounded,
            size: bigIconSize,
            color: Colors.transparent,
          ),
        ),
        Text(
          state ? 'Hide More Fields' : 'More Fields',
          style: styleH5.copyWith(
            color: darkAccentColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
