import 'package:call_app/components/contact_image.dart';
import 'package:call_app/main.dart';
import 'package:call_app/models/contact.dart';
import 'package:call_app/resources/constants.dart';
import 'package:call_app/router/paths.dart';

Widget recentCard(
  BuildContext context, {
  required Contact? contact,
  required DateTime occurrence,
  required String phone,
  required int flag,
  required int id,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Row(
      children: [
        TextButton(
          onPressed: () {
            context.pushNamed(
              Paths.contactInfo,
              queryParams: {'phone': phone, 'id': id.toString()},
              extra: contact,
            );
          },
          child: contactImage(
            name: contact?.name,
            fillColorHex: contact?.hexColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 10),
          child: GestureDetector(
            onLongPress: () {
              objectBox.recentsBox.remove(id);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact == null ? phone : contact.name,
                  style: const TextStyle(
                    fontSize: sizeH3,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      flag == 0
                          ? Icons.call_missed
                          : flag == 1
                              ? Icons.call_made
                              : Icons.call_received,
                    ),
                    Text(
                      worldTime.format(dateTime: occurrence, formatter: formatter),
                    ),
                  ],
                ),
                const Text('Country'), // TODO
              ],
            ),
          ),
        ),
        Expanded(child: Container()),
        IconButton(
          onPressed: () async {
            await objectBox.addRecent(contact: contact, phone: phone, occurrence: DateTime.now(), state: 1);
          },
          icon: const Icon(
            Icons.call_outlined,
            size: regularIconSize,
          ),
        ),
      ],
    ),
  );
}
