import 'package:call_app/main.dart';
import 'package:call_app/models/contact.dart';
import 'package:call_app/models/recent_contact.dart';
import 'package:call_app/resources/constants.dart';
import 'package:call_app/resources/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/contact_image.dart';

class RecentsPage extends StatefulWidget {
  const RecentsPage({Key? key}) : super(key: key);

  @override
  State<RecentsPage> createState() => _RecentsPageState();
}

class _RecentsPageState extends State<RecentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<RecentContact>>(
                stream: objectbox.getRecents(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                    itemBuilder: (context, index) {
                      final List<RecentContact> recents = snapshot.data ?? [];
                      return recentsWidget(
                        contact: recents[index].contact.target!,
                        occurrence: recents[index].occurrenceDate,
                        id: recents[index].id,
                        flag: recents[index].status,
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget recentsWidget({
    required Contact contact,
    required DateTime occurrence,
    required int flag,
    required int id,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              context.go(Paths.contactInfo, extra: contact);
            },
            child: contactImage(firstName: contact.firstName),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 10),
            child: GestureDetector(
              onLongPress: () {
                objectbox.recentsBox.remove(id);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${contact.firstName} ${contact.lastName ?? ''}',
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
              await objectbox.addRecent(contact: contact, occurrence: DateTime.now(), state: 1);
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
}
