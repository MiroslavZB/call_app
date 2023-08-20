import 'package:call_app/components/contact_image.dart';
import 'package:call_app/components/new_contact/add_image_box.dart';
import 'package:call_app/components/new_contact/add_image_text.dart';
import 'package:call_app/components/new_contact/app_bar.dart';
import 'package:call_app/components/new_contact/change_and_remove_image_text.dart';
import 'package:call_app/components/new_contact/primary_fields.dart';
import 'package:call_app/components/new_contact/secondary_fields.dart';
import 'package:call_app/models/contact.dart';
import 'package:call_app/resources/constants.dart';
import 'package:call_app/resources/keyboard_visibility_listener.dart';
import 'package:call_app/router/paths.dart';

class NewContactPage extends StatefulWidget {
  const NewContactPage({
    Key? key,
    this.contact,
    this.phone = '',
  }) : super(key: key);

  final Contact? contact;
  final String? phone;

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

final Map<String, TextEditingController> fields = {};

class _NewContactPageState extends State<NewContactPage> {
  @override
  void initState() {
    super.initState();
    fields.clear();
    if (widget.contact != null) {
      widget.contact!.toJson().forEach((key, value) {
        if (value is String) {
          fields.addAll({key: TextEditingController(text: value)});
        }
      });
    } else if (widget.phone?.isNotEmpty == true) {
      fields.addAll({'Phone': TextEditingController(text: widget.phone)});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            appBar(context, isNew: widget.contact == null, makeContact: makeContact),
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
                        InkWell(
                          onTap: () {
                            // TODO
                          },
                          child: Column(
                            children: widget.contact == null || widget.contact!.image == null
                                ? [
                                    addImageBox(context),
                                    addImageText(),
                                  ]
                                : [
                                    contactImage(
                                      name: widget.contact!.name,
                                      size: MediaQuery.of(context).size.width / 3,
                                      fillColorHex: widget.contact!.hexColor,
                                    ),
                                    changeAndRemoveImageText(),
                                  ],
                          ),
                        ),
                        primaryFields(),
                        secondaryFields(),
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

  // Makes a Contact object out of the current text fields
  Contact makeContact() => Contact(
        id: widget.contact?.id ?? 0,
        hexColor: widget.contact?.hexColor ?? flutterGreyColorHex,
        firstName: fields['First name']?.text ?? '',
        phone: fields['Phone']?.text ?? '',
        image: null, // TODO
        lastName: fields['Last name']?.text,
        company: fields['Company']?.text,
        email: fields['Email']?.text,
        label: fields['label']?.text,
        significantDate: null, // unfinished
        significantDateLabel: null, // unfinished
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
        addressLabel: null, // unfinished
        address: fields['Address']?.text,
        website: fields['Website']?.text,
        relatedPerson: fields['Relationship']?.text,
        relationshipToRelatedPerson: null, // unfinished
        sip: fields['sip']?.text,
      );
}
