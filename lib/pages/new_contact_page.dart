import 'package:call_app/components/contact_image.dart';
import 'package:call_app/main.dart';
import 'package:call_app/models/contact.dart';
import 'package:call_app/resources/constants.dart';
import 'package:call_app/resources/keyboard_visibility_listener.dart';
import 'package:call_app/resources/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final TextEditingController controller = TextEditingController();

class NewContactPage extends StatefulWidget {
  const NewContactPage({
    Key? key,
    this.contact,
    this.fromRecents = 'false',
    this.phone = '',
    this.id = '',
  }) : super(key: key);

  final Contact? contact;
  final String? phone;
  final String? fromRecents;
  final String? id;

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final Map<String, TextEditingController> fields = {};

  @override
  void initState() {
    if (widget.contact != null) {
      widget.contact!.toJson().forEach((key, value) {
        if (value is String) {
          fields.addAll({key: TextEditingController(text: value)});
        }
      });
    } else if (widget.phone != null && widget.phone != '') {
      fields.addAll({'Phone': TextEditingController(text: widget.phone)});
    }
    super.initState();
  }

  bool firstNameArrowDown = false; // TODO
  bool moreFieldsState = false; // TODO

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            topRow(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: KeyboardVisibilityListener(
                    listener: (isKeyboardVisible) {
                      if (!isKeyboardVisible) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                    child: Column(
                      children: [
                        ...addImageWidgets(widget.contact == null || widget.contact!.image == null),
                        ...allFields(),
                        moreFieldsButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> allFields() {
    return [
      if (firstNameArrowDown) sharedField(hint: 'Name prefix'),
      sharedField(
        leading: Icons.person_outline_rounded,
        hint: 'First name',
        firstNameArrowDown: true,
      ),
      if (firstNameArrowDown) sharedField(hint: 'Middle name'),
      sharedField(hint: 'Last name'),
      if (firstNameArrowDown) sharedField(hint: 'Name suffix'),
      if (moreFieldsState) ...[
        sharedField(hint: 'Phonetic last name'),
        sharedField(hint: 'Phonetic middle name'),
        sharedField(hint: 'Phonetic first name'),
        sharedField(hint: 'Nickname'),
        sharedField(hint: 'File as'),
      ],
      sharedField(leading: Icons.factory_outlined, hint: 'Company'),
      if (moreFieldsState) ...[
        sharedField(hint: 'Department'),
        sharedField(hint: 'Title'),
      ],
      sharedField(leading: Icons.phone_outlined, hint: 'Phone'),
      // TODO label
      sharedField(leading: Icons.email_outlined, hint: 'Email'),
      // TODO email label
      if (moreFieldsState) ...[
        sharedField(hint: 'Address'),
        // TODO address label
        sharedField(hint: 'website'),
      ],
      // TODO significant date
      // TODO birthday
      if (moreFieldsState) ...[
        sharedField(hint: 'SIP'),
        // TODO relationship
        sharedField(hint: 'Notes'),
        // TODO label
      ],
    ];
  }

  List<Widget> addImageWidgets(bool isAdd) {
    if (isAdd) return [addImageButton(), addImageTextButton()];
    return [
      contactImage(
        name: widget.contact!.name,
        size: MediaQuery.of(context).size.width / 3,
        fillColorHex: widget.contact!.hexColor,
      ),
      changeOrRemoveImageText(),
    ];
  }

  // Widgets
  Widget topRow() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {
              context.goNamed(
                Paths.contactInfo,
                extra: widget.contact,
                queryParams: {'fromRecents': widget.fromRecents, 'phone': widget.phone},
              );
            },
            icon: const Icon(
              Icons.close,
              size: bigIconSize,
            ),
          ),
        ),
        Text(
          widget.contact == null ? 'Create contact' : 'Edit contact',
          style: const TextStyle(
            fontSize: sizeH3,
          ),
        ),
        Expanded(child: Container()),
        InkWell(
          onTap: () async {
            widget.contact == null ? await createContact() : await updateContact();
            if (widget.phone != null && widget.phone != '' && widget.id != null && widget.id != '0') {
              //  updateRecent();
            }
            if (context.mounted) {
              context.goNamed(
                Paths.contactInfo,
                queryParams: {'fromRecents': widget.fromRecents},
                extra: currentContact(id: widget.contact?.id ?? 0),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
              top: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(77, 92, 142, 1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white, fontSize: sizeH4),
            ),
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

  Widget addImageButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        height: MediaQuery.of(context).size.width / 3,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: lightAccentColor,
        ),
        child: const Center(
          child: Icon(
            Icons.image_outlined,
            size: extraBigIconSize,
          ),
        ),
      ),
    );
  }

  Widget addImageTextButton() {
    return const Padding(
      padding: EdgeInsets.only(top: 10, bottom: 40),
      child: Text(
        'Add picture',
        style: TextStyle(
          color: Color.fromRGBO(77, 92, 142, 1),
          fontSize: sizeH5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget changeOrRemoveImageText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            // TODO!
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.edit_outlined,
                color: darkAccentColor,
              ),
              Text(
                'Change',
                style: TextStyle(
                  color: darkAccentColor,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            // TODO!
          },
          child: const Row(
            children: [
              Icon(
                Icons.restore_from_trash_outlined,
                color: darkAccentColor,
              ),
              Text(
                'Remove',
                style: TextStyle(
                  color: darkAccentColor,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget moreFieldsButton() {
    return InkWell(
      onTap: () {
        // TODO
      },
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.person_outline_rounded,
              size: bigIconSize,
              color: Colors.transparent,
            ),
          ),
          Text(
            'More Fields',
            style: TextStyle(
              fontSize: sizeH5,
              color: darkAccentColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget sharedField({
    required String hint,
    IconData? leading,
    bool firstNameArrowDown = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Icon(
              leading ?? Icons.person_outline_rounded,
              size: bigIconSize,
              color: leading != null ? Colors.black : Colors.transparent,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextFormField(
                controller: fields[hint],
                onChanged: (value) {
                  fields[hint] = TextEditingController();
                  fields[hint]!.text = value;
                },
                decoration: InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: firstNameArrowDown ? () {
              // TODO
            } : null,
            icon: Icon(
              Icons.keyboard_arrow_down_outlined,
              size: bigIconSize,
              color: firstNameArrowDown ? Colors.black : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  // Makes a Contact object out of the current text fields
  Contact currentContact({int id = 0, int? hexColor}) => Contact(
        id: id,
        hexColor: hexColor ?? 0xFF9E9E9E, // Colors.grey's hex code
        firstName: fields['First name']?.text ?? '',
        phone: fields['Phone']?.text ?? '',
        image: null, // TODO
        lastName: fields['Last name']?.text,
        company: fields['Company']?.text,
        email: fields['Email']?.text,
        label: fields['label']?.text,
        significantDate: null, // TODO
        significantDateLabel: null, // TODO
        namePrefix: fields['Name prefix']?.text,
        middleName: fields['Middle name']?.text,
        nameSuffix: fields['Name suffix']?.text,
        phoneticLastName: fields['Phonetic last name']?.text,
        phoneticMiddleName: fields['Phonetic middle name']?.text,
        phoneticFirstName: fields['Phonetic first name']?.text,
        nickname: fields['Nickname']?.text,
        fileAs: fields['File as']?.text,
        department: fields['Department']?.text,
        title: fields['Title']?.text,
        addressLabel: null, // TODO
        address: fields['Address']?.text,
        website: fields['Website']?.text,
        relatedPerson: fields['Relationship']?.text,
        relationshipToRelatedPerson: null, // TODO
        sip: fields['sip']?.text,
      );

  // Functions
  Future<void> createContact() async {
    await objectbox.addContact(
      currentContact(),
    );
  }

  Future<void> updateContact() async {
    await objectbox.putContact(currentContact(id: widget.contact!.id));
  }
}
