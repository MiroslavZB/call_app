import 'package:call_app/functions/update_recents.dart';
import 'package:call_app/main.dart';
import 'package:call_app/models/contact.dart';
import 'package:call_app/resources/constants.dart';
import 'package:call_app/router/paths.dart';

Widget appBar(
  BuildContext context, {
  required bool isNew,
  required Contact Function() makeContact,
}) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.close,
            size: bigIconSize,
          ),
        ),
      ),
      Text(
        isNew ? 'Create contact' : 'Edit contact',
        style: styleH3,
      ),
      Expanded(child: Container()),
      Padding(
        padding: const EdgeInsets.only(right: 5),
        child: InkWell(
          onTap: () async {
            final Contact contact = makeContact();
            await objectBox.putContact(contact);
            if (!isNew) {
              await updateRecents(contact);
            }
            if (context.mounted) {
              context.pop();
              if (isNew) {
                context.push(
                  Paths.contactInfo,
                  extra: contact,
                );
              } else {
                context.pushReplacement(
                  Paths.contactInfo,
                  extra: contact,
                );
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(77, 92, 142, 1),
              borderRadius: BorderRadius.circular(bigBorderRadius),
            ),
            child: Text('Save', style: styleH4.copyWith(color: Colors.white)),
          ),
        ),
      ),
      // IconButton(
      //   onPressed: () {
      //      unfinished
      //   },
      //   icon: const Icon(
      //     Icons.more_vert_outlined,
      //     size: bigIconSize,
      //   ),
      // )
    ],
  );
}
