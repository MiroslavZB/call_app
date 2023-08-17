import 'package:call_app/components/contact_image.dart';
import 'package:call_app/functions/highlight_pattern.dart';
import 'package:call_app/models/contact.dart';
import 'package:call_app/resources/constants.dart';
import 'package:call_app/router/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget contactCard(
  BuildContext context, {
  required Contact contact,
  required String thisInitial,
  required String previousInitial,
  String? phoneFilter,
  String? nameFilter,
}) {
  return GestureDetector(
    onTap: () => context.pushNamed(Paths.contactInfo, extra: contact),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 20,
              child: Center(
                child: Text(
                  previousInitial.toLowerCase() == thisInitial.toLowerCase() ? '' : thisInitial.toUpperCase(),
                  style: const TextStyle(
                    fontSize: sizeH3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: contactImage(
              name: contact.name,
              image: contact.image,
              fillColorHex: contact.hexColor,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: sizeH4),
                TextSpan(
                  children: nameFilter != null && nameFilter.isNotEmpty
                      ? highlightPattern(contact.name, nameFilter)
                      : [TextSpan(text: contact.name)],
                ),
              ),
              if (phoneFilter != null && phoneFilter.isNotEmpty)
                Text.rich(
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: sizeH4),
                  TextSpan(children: highlightPattern(contact.phone, phoneFilter)),
                )
            ],
          )
        ],
      ),
    ),
  );
}
