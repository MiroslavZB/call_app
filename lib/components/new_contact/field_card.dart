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
  fields[hint] ??= TextEditingController();
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: leading != null
              ? Icon(
                  leading,
                  size: bigIconSize,
                  color: Colors.black,
                )
              : emptyBox(bigIconSize),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(4),
            ),
            child: TextFormField(
              controller: fields[hint],
              onChanged: (value) => fields[hint]!.text = value,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        context != null
            ? IconButton(
                onPressed: () => BlocProvider.of<SharedBoolState>(context).flip(),
                icon: Icon(
                  state ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_outlined,
                  size: bigIconSize,
                  color: Colors.black,
                ),
              )
            : emptyBox(bigIconSize + 18), // 18 is the padding of the IconButton
      ],
    ),
  );
}
