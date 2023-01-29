import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Contact {
  int id;
  DateTime date;

  // Required
  String firstName;
  String phone;

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
}
