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
      'sip': sip,
    };
  }

  Contact copyWith({
    DateTime? date,

    // Required
    String? firstName,
    String? phone,
    int? hexColor,

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
}
