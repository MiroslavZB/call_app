import 'package:call_app/models/contact.dart';
import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class RecentContact {
  int id;
  final contact = ToOne<Contact>();
  final String phone;
  final DateTime occurrenceDate;

  // 0 - missed, 1 - outgoing, 2 - incoming
  final int status;

  RecentContact({
    this.id = 0,
    required this.phone,
    required this.status,
    required this.occurrenceDate,
  });

  RecentContact copyWith(Contact contact) {
    final RecentContact object = RecentContact(
      id: id,
      phone: phone,
      status: status,
      occurrenceDate: occurrenceDate,
    );
    object.contact.target = contact;

    return object;
  }

  String get dateFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(occurrenceDate);
}
