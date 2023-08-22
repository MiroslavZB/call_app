import 'package:call_app/functions/make_random_hex_color.dart';
import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Contact {
  int id;
  DateTime date;

  // Required
  String firstName;
  String phone;
  int hexColor;
  String? streetAddress1;
  String? streetAddress2;
  String? city;
  String? state;
  String? zip;
  String? customId;

  // Extra
  bool isFavorite;

  // Main
  String? image;
  String? lastName;
  String? company;
  String? email;
  String? label;
  DateTime? significantDate;
  String? significantDateLabel;

  // Extra
  String? namePrefix;
  String? middleName;
  String? nameSuffix;
  String? phoneticLastName;
  String? phoneticMiddleName;
  String? phoneticFirstName;
  String? nickname;
  String? fileAs;
  String? department;
  String? title;
  String? addressLabel;
  String? address;
  String? website;
  String? relatedPerson;
  String? relationshipToRelatedPerson;
  String? sip;

  Contact({
    this.id = 0,
    required this.firstName,
    required this.phone,
    required this.hexColor,
    this.isFavorite = false,
    this.streetAddress1,
    this.streetAddress2,
    this.city,
    this.state,
    this.zip,
    this.customId,
    this.image,
    this.lastName,
    this.company,
    this.email,
    this.label,
    this.significantDate,
    this.significantDateLabel,
    this.namePrefix,
    this.middleName,
    this.nameSuffix,
    this.phoneticLastName,
    this.phoneticMiddleName,
    this.phoneticFirstName,
    this.nickname,
    this.fileAs,
    this.department,
    this.title,
    this.addressLabel,
    this.address,
    this.website,
    this.relatedPerson,
    this.relationshipToRelatedPerson,
    this.sip,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  String get dateFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(date);

  String get name => [firstName, if (lastName != null) lastName].join(' ');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'First name': firstName,
      'Phone': phone,
      'image': image,
      'Street Address 1': streetAddress1,
      'Street Address 2': streetAddress2,
      'City': city,
      'State': state,
      'Zip': zip,
      'customId': customId,
      'isFavorite': isFavorite,
      'Last name': lastName,
      'Company': company,
      'Email': email,
      'Label': label,
      'Significant date': significantDate,
      'Significant late label': significantDateLabel,
      'Name prefix': namePrefix,
      'Middle name': middleName,
      'Name suffix': nameSuffix,
      'Phonetic last name': phoneticLastName,
      'Phonetic middle name': phoneticMiddleName,
      'Phonetic first name': phoneticFirstName,
      'Nickname': nickname,
      'File as': fileAs,
      'Department': department,
      'Title': title,
      'Address label': addressLabel,
      'Address': address,
      'Website': website,
      'Related person': relatedPerson,
      'Relationship to related person': relationshipToRelatedPerson,
      'SIP': sip,
    };
  }

  Contact copyWith({
    DateTime? date,

    // Required
    String? firstName,
    String? phone,
    int? hexColor,
    String? streetAddress1,
    String? streetAddress2,
    String? city,
    String? state,
    String? zip,
    String? customId,

    // Extra
    bool? isFavorite,

    // Main
    String? image,
    String? lastName,
    String? company,
    String? email,
    String? label,
    DateTime? significantDate,
    String? significantDateLabel,
    // Extra
    String? namePrefix,
    String? middleName,
    String? nameSuffix,
    String? phoneticLastName,
    String? phoneticMiddleName,
    String? phoneticFirstName,
    String? nickname,
    String? fileAs,
    String? department,
    String? title,
    String? addressLabel,
    String? address,
    String? website,
    String? relatedPerson,
    String? relationshipToRelatedPerson,
    String? sip,
  }) {
    return Contact(
      id: id,
      firstName: firstName ?? this.firstName,
      phone: phone ?? this.phone,
      hexColor: hexColor ?? this.hexColor,
      isFavorite: isFavorite ?? this.isFavorite,
      image: image ?? this.image,
      lastName: lastName ?? this.lastName,
      streetAddress1: streetAddress1 ?? this.streetAddress1,
      streetAddress2: streetAddress2 ?? this.streetAddress2,
      city: city ?? this.city,
      state: state ?? this.state,
      zip: zip ?? this.zip,
      customId: customId ?? this.customId,
      company: company ?? this.company,
      email: email ?? this.email,
      label: label ?? this.label,
      significantDate: significantDate ?? this.significantDate,
      significantDateLabel: significantDateLabel ?? this.significantDateLabel,
      namePrefix: namePrefix ?? this.namePrefix,
      middleName: middleName ?? this.middleName,
      nameSuffix: nameSuffix ?? this.nameSuffix,
      phoneticLastName: phoneticLastName ?? this.phoneticLastName,
      phoneticMiddleName: phoneticMiddleName ?? this.phoneticMiddleName,
      phoneticFirstName: phoneticFirstName ?? this.phoneticFirstName,
      nickname: nickname ?? this.nickname,
      fileAs: fileAs ?? this.fileAs,
      department: department ?? this.department,
      title: title ?? this.title,
      addressLabel: addressLabel ?? this.addressLabel,
      address: address ?? this.address,
      website: website ?? this.website,
      relatedPerson: relatedPerson ?? this.relatedPerson,
      relationshipToRelatedPerson: relationshipToRelatedPerson ?? this.relationshipToRelatedPerson,
      sip: sip ?? this.sip,
    );
  }

  @override
  toString() => toJson().toString();

  static Contact? fromJson(Map<String, dynamic> e) {
    // validates the json
    if ([
      e['customId'] is! String?,
      e['firstName'] is! String?,
      e['lastName'] is! String?,
      e['phone'] is! String,
      e['streetAddress1'] is! String?,
      e['streetAddress2'] is! String?,
      e['city'] is! String?,
      e['state'] is! String?,
      e['zip'] is! String?,
      // int.tryParse(e['hexColor']) == null,
    ].contains(true)) {
      return null;
    }

    try {
      return Contact(
        customId: e['customId'],
        firstName: e['firstName'],
        lastName: e['lastName'],
        phone: e['phone'],
        streetAddress1: e['streetAddress1'],
        streetAddress2: e['streetAddress2'],
        city: e['city'],
        state: e['state'],
        zip: e['zip'],
        hexColor: int.tryParse(e['hexColor'] ?? '') ?? getRandomHexColor(),
      );
    } catch (e) {
      return null;
    }
  }
}
