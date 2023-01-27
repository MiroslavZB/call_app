import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Note {
  int id;

  String text;
  String? comment;

  DateTime date;

  Note(this.text, {this.id = 0, this.comment, DateTime? date}) : date = date ?? DateTime.now();

  String get dateFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(date);
}
