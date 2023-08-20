import 'package:call_app/pages/new_contact_page.dart';
import 'package:call_app/resources/constants.dart';
import 'package:call_app/state/shared_bool_state.dart';
import 'package:flutter/material.dart';

Widget sharedField({
  required String hint,
  bool showArrowDown = false,
  IconData? leading,
  BuildContext? context,
  bool state = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Icon(
            leading ?? Icons.person_outline_rounded,
            size: bigIconSize,
            color: leading != null ? Colors.black : Colors.transparent,
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(4),
            ),
            child: TextFormField(
              controller: fields[hint],
              onChanged: (value) {
                fields[hint] = TextEditingController();
                fields[hint]!.text = value;
              },
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: showArrowDown ? () => BlocProvider.of<SharedBoolState>(context!).flip() : null,
          icon: Icon(
            state ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_outlined,
            size: bigIconSize,
            color: showArrowDown ? Colors.black : Colors.transparent,
          ),
        ),
      ],
    ),
  );
}
