import 'package:call_app/components/contact_image.dart';
import 'package:call_app/main.dart';
import 'package:call_app/models/contact.dart';
import 'package:call_app/resources/constants.dart';
import 'package:call_app/resources/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactInfoPage extends StatelessWidget {
  const ContactInfoPage({
    Key? key,
    required this.contact,
    this.phone = '',
    this.fromRecents = 'false',
    this.id = '0',
  }) : super(key: key);

  final Contact? contact;
  final String? fromRecents;
  final String? phone;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            topRow(context),
            contactImage(
              firstName: contact == null ? '' : contact!.firstName,
              image: contact?.image,
              size: MediaQuery.of(context).size.width / 3,
              fillColorHex: contact?.hexColor,
            ),
            nameWidget(),
            ...buttonsWidgets(),
            contactInfoWidget(),
          ],
        ),
      ),
    );
  }

  Widget topRow(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {
              fromRecents == 'true' ? context.go(Paths.recents) : context.go(Paths.contacts);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: regularIconSize,
            ),
          ),
        ),
        Expanded(child: Container()),
        IconButton(
          onPressed: () {
            context.goNamed(
              Paths.newContact,
              queryParams: {'fromRecents': fromRecents, 'phone': phone},
              extra: contact,
            );
          },
          icon: const Icon(
            Icons.edit_outlined,
            size: regularIconSize,
          ),
        ),
        IconButton(
          onPressed: () {
            // TODO
          },
          icon: Icon(
            contact != null && contact!.isFavorite ? Icons.star : Icons.star_border,
            size: regularIconSize,
          ),
        ),
        IconButton(
          onPressed: () {
            // TODO
          },
          icon: const Icon(
            Icons.more_vert_outlined,
            size: bigIconSize,
          ),
        )
      ],
    );
  }

  Widget iconButtonWidget({
    required IconData icon,
    required String text,
    required Function() onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Icon(icon, size: bigIconSize, color: darkAccentColor),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: sizeH4, color: darkAccentColor),
          ),
        ],
      ),
    );
  }

  Widget nameWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        contact?.firstName ?? phone ?? 'Unknown',
        style: const TextStyle(
          fontSize: sizeH2,
        ),
      ),
    );
  }

  List<Widget> buttonsWidgets() {
    return [
      const Divider(
        height: 40,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          iconButtonWidget(
              icon: Icons.call_outlined,
              text: 'Call',
              onPressed: () async {
                await objectbox.addRecent(
                  contact: contact,
                  phone: contact?.phone ?? phone ?? 'Unknown',
                  occurrence: DateTime.now(),
                  state: 1,
                );
              }),
          iconButtonWidget(
              icon: Icons.message_outlined,
              text: 'Text',
              onPressed: () {
                // TODO
              }),
          iconButtonWidget(
              icon: Icons.videocam_outlined,
              text: 'Video',
              onPressed: () {
                // TODO
              }),
        ],
      ),
      const Divider(
        height: 40,
      ),
    ];
  }

  Widget contactInfoWidget() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Contact info',
                style: TextStyle(
                  fontSize: sizeH5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.phone_outlined,
                    size: bigIconSize,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      contact?.phone ?? phone ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: sizeH5,
                      ),
                    ),
                    const Text(
                      'Mobile via ',
                      style: TextStyle(
                        fontSize: sizeH6,
                      ),
                    )
                  ],
                ),
                Expanded(child: Container()),
                const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.videocam_outlined,
                    size: regularIconSize,
                  ),
                ),
                const Icon(
                  Icons.message_outlined,
                  size: regularIconSize,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
