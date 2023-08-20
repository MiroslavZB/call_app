import 'package:call_app/main.dart';

Future<void> updateRecents(int id) async{
  objectBox.recentsBox.getAll().where((e) => e.id == id).forEach((e) {

  });
}
