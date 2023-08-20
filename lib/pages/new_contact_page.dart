import 'package:call_app/components/contact_image.dart';
import 'package:call_app/components/new_contact/add_image_box.dart';
import 'package:call_app/components/new_contact/add_image_text.dart';
import 'package:call_app/components/new_contact/app_bar.dart';
import 'package:call_app/components/new_contact/change_and_remove_image_text.dart';
import 'package:call_app/components/new_contact/primary_fields.dart';
import 'package:call_app/components/new_contact/secondary_fields.dart';
import 'package:call_app/functions/add_image.dart';
import 'package:call_app/functions/make_random_hex_color.dart';
import 'package:call_app/models/contact.dart';
import 'package:call_app/resources/keyboard_visibility_listener.dart';
import 'package:call_app/router/paths.dart';
import 'package:call_app/state/image_picker_state.dart';

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
    return BlocProvider(
      create: (_) => ImagePickerState(),
      child: BlocBuilder<ImagePickerState, String?>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  appBar(context, isNew: widget.contact == null, makeContact: () => makeContact(state)),
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
                                onTap: () => addImage(context),
                                child: state?.isEmpty == true || (widget.contact?.image == null && state == null)
                                    ? Column(
                                        children: [
                                          addImageBox(context),
                                          addImageText(),
                                        ],
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                                        child: contactImage(
                                          name: widget.contact?.name,
                                          image: state == null
                                              ? widget.contact?.image
                                              : state.isEmpty
                                                  ? null
                                                  : state,
                                          size: MediaQuery.of(context).size.width / 3,
                                          fillColorHex: widget.contact?.hexColor,
                                        ),
                                      ),
                              ),
                              if ((widget.contact?.image?.isNotEmpty ?? false || state != null) &&
                                  !(state?.isEmpty == true))
                                changeAndRemoveImageText(context),
                              primaryFields(),
                              secondaryFields(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Makes a Contact object out of the current text fields
  Contact makeContact(String? state) {
    String? image;
    if (state != null) {
      // state can be returned as '' in order to clear the image.
      image = state.isNotEmpty ? state : null;
    } else {
      image = widget.contact?.image;
    }
    return Contact(
      id: widget.contact?.id ?? 0,
      hexColor: widget.contact?.hexColor ?? getRandomHexColor(),
      firstName: fields['First name']?.text ?? '',
      phone: fields['Phone']?.text ?? '',
      image: image,
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
      sip: fields['SIP']?.text,
    );
  }
}
