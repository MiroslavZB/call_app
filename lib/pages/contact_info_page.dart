import 'package:call_app/components/contact_image.dart';
import 'package:call_app/components/icon_button_widget.dart';
import 'package:call_app/main.dart';
import 'package:call_app/models/contact.dart';
import 'package:call_app/resources/constants.dart';
import 'package:call_app/router/paths.dart';
import 'package:call_app/state/shared_bool_state.dart';

class ContactInfoPage extends StatelessWidget {
  const ContactInfoPage({
    Key? key,
    required this.contact,
    this.phone = '',
  }) : super(key: key);

  final Contact? contact;
  final String? phone;

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
              name: contact?.name,
              image: contact?.image,
              size: MediaQuery.of(context).size.width / 3,
              fillColorHex: contact?.hexColor,
            ),
            nameWidget(),
            ...buttonsWidgets(context),
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
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back,
              size: regularIconSize,
            ),
          ),
        ),
        Expanded(child: Container()),
        if (contact != null)
          IconButton(
            onPressed: () {
              objectBox.contactsBox.remove(contact!.id);
              context.pop();
            },
            icon: const Icon(Icons.delete_forever),
          ),
        IconButton(
          onPressed: () {
            context.pushNamed(
              Paths.newContact,
              queryParams: {'phone': phone},
              extra: contact,
            );
          },
          icon: const Icon(
            Icons.edit_outlined,
            size: regularIconSize,
          ),
        ),
        BlocProvider(
          create: (_) => SharedBoolState(contact?.isFavorite ?? false),
          child: BlocBuilder<SharedBoolState, bool>(
            builder: (context, state) => IconButton(
              onPressed: contact == null
                  ? null
                  : () => objectBox
                      .putContact(contact!.copyWith(isFavorite: !state))
                      .whenComplete(() => BlocProvider.of<SharedBoolState>(context).flip()),
              icon: Icon(
                contact != null && state ? Icons.star : Icons.star_border,
                size: regularIconSize,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget nameWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        contact?.name ?? phone ?? 'Unknown',
        style: styleH2,
      ),
    );
  }

  List<Widget> buttonsWidgets(BuildContext context) {
    return [
      const Divider(height: 40),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          iconButtonWidget(
            icon: Icons.call_outlined,
            text: 'Call',
            onPressed: (contact?.phone.length ?? 0) < 3
                ? null
                : () => objectBox
                        .addRecent(
                      contact: contact,
                      phone: contact?.phone ?? phone ?? 'Unknown',
                      occurrence: DateTime.now(),
                      state: 1,
                    )
                        .whenComplete(() {
                      context.pop();
                      context.go(Paths.recents);
                    }),
          ),
          iconButtonWidget(
            icon: Icons.message_outlined,
            text: 'Text',
            onPressed: null, // unfinished
          ),
          iconButtonWidget(
            icon: Icons.videocam_outlined,
            text: 'Video',
            onPressed: null, // unfinished
          ),
        ],
      ),
      const Divider(height: 40),
    ];
  }

  Widget contactInfoWidget() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(smallBorderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Contact info',
                style: styleH5.copyWith(fontWeight: FontWeight.bold),
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
                    SelectableText(
                      contact?.phone ?? phone ?? 'Unknown',
                      style: styleH5,
                    ),
                    const Text(
                      'Mobile',
                      style: styleH6,
                    )
                  ],
                ),
                Expanded(child: Container()),
                // const Padding(
                //   padding: EdgeInsets.only(right: 20),
                //   child: Icon(
                //     Icons.videocam_outlined,
                //     size: regularIconSize,
                //   ),
                // ),
                // const Icon(
                //   Icons.message_outlined,
                //   size: regularIconSize,
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
