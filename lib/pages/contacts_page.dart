import 'package:call_app/components/contact_image.dart';
import 'package:call_app/main.dart';
import 'package:call_app/models/contact.dart';
import 'package:call_app/resources/constants.dart';
import 'package:call_app/resources/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkAccentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        onPressed: () => {
          // TODO
        },
        child: const Icon(Icons.dialpad_outlined, size: regularIconSize),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: StreamBuilder<List<Contact>>(
                stream: objectbox.getContacts(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    itemCount: snapshot.hasData ? snapshot.data!.length + 1 : 1,
                    itemBuilder: (context, index) {
                      if (index == 0) return createNewContactWidget();
                      final List<Contact> contacts = snapshot.data ?? [];
                      return contactWidget(
                        contact: contacts[index - 1],
                        thisInitial: contacts[index - 1].firstName.isEmpty
                            ? ''
                            : contacts[index - 1].firstName.substring(0, 1),
                        previousInitial: index < 2 || contacts[index - 2].firstName.isEmpty
                            ? ''
                            : contacts[index - 2].firstName.substring(0, 1),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget createNewContactWidget() {
    return SizedBox(
      height: 40,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateColor.resolveWith((states) => Colors.grey[300]!),
        ),
        onPressed: () {
          context.go(Paths.newContact);
        },
        child: Row(
          children: const [
            Icon(
              Icons.person_add_alt_outlined,
              color: darkAccentColor,
              size: 25,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Create new contact',
                style: TextStyle(
                  fontSize: 20,
                  color: darkAccentColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget contactWidget({required Contact contact, required String thisInitial, required String previousInitial}) {
    return GestureDetector(
      onTap: () => context.go(Paths.contactInfo, extra: contact),
      onLongPress: () => objectbox.contactsBox.remove(contact.id),
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
                firstName: contact.firstName,
                image: contact.image,
                fillColorHex: contact.hexColor,
              ),
            ),
            Text(
              '${contact.firstName} ${contact.lastName ?? ''}',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: sizeH4,
              ),
            )
          ],
        ),
      ),
    );
  }
}
