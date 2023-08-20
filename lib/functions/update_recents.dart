import 'package:call_app/main.dart';
import 'package:call_app/models/contact.dart';

Future<void> updateRecents(Contact contact) async {
  objectBox.recentsBox.getAll().where((e) => e.contact.target?.id == contact.id).forEach((e) {
    objectBox.putRecent(e.copyWith(contact));
  });
}
