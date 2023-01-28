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
                        image: contacts[index - 1].image,
                        name: contacts[index - 1].firstName,
                        index: index,

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

  contactWidget({required String image, required String name, int? index}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name.substring(0, 1),
              key: Key('list_item_$index'),
            ),
          ),
          //  Image.memory(base64Decode(image), height: extraBigIconSize, width: extraBigIconSize,),
          Text(name)
        ],
      ),
    );
  }
}
