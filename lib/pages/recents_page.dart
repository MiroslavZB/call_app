import 'package:call_app/main.dart';
import 'package:call_app/models/contact.dart';
import 'package:flutter/material.dart';

class RecentsPage extends StatefulWidget {
  const RecentsPage({Key? key}) : super(key: key);

  @override
  State<RecentsPage> createState() => _RecentsPageState();
}

Future<void> _addContact() async {
  await objectbox.addContact(
    Contact(
      firstName: 'firstName',
      phone: 'phone',
      photo: 'photo',
    ),
  );
}

class _RecentsPageState extends State<RecentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<Contact>>(
              stream: objectbox.getContacts(),
              builder: (context, snapshot) => ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                itemBuilder: (context, index) {
                  final List<Contact> contacts = snapshot.data ?? [];
                  return GestureDetector(
                    onTap: () => objectbox.contactsBox.remove(contacts[index].id),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.black12),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    contacts[index].firstName,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                    // Provide a Key for the integration test
                                    key: Key('list_item_$index'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      'Added on ${contacts[index].dateFormat}',
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('submit'),
        onPressed: () => _addContact,
        child: const Icon(Icons.add),
      ),
    );
  }
}
