import 'package:call_app/components/contact/contact_card.dart';
import 'package:call_app/components/empty_view_text.dart';
import 'package:call_app/main.dart';
import 'package:call_app/models/contact.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<List<Contact>>(
          stream: objectBox.getContacts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.data?.isNotEmpty != true ||
                !snapshot.data!.any((e) => e.isFavorite)) {
              return emptyViewText('No Favorites yet!');
            }
            final List<Contact> contacts = snapshot.data!.where((e) => e.isFavorite).toList();
            return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return contactCard(
                    context,
                    contact: contact,
                    currentInitial: contact.name.isEmpty ? '' : contact.name.substring(0, 1),
                    previousInitial: index < 1 || contacts[index - 1].name.isEmpty
                        ? ''
                        : contacts[index - 1].name.substring(0, 1),
                  );
                });
          }),
    );
  }
}
