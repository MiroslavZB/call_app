import 'package:call_app/main.dart';
import 'package:call_app/resources/constants.dart';
import 'package:call_app/router/paths.dart';
import 'package:collection/collection.dart';

Widget callingCallButton(BuildContext context, TextEditingController callController) {
  return InkWell(
    onTap: () {
      if (callController.text.length < 2) return;
      objectBox
          .addRecent(
        contact: objectBox.getContactsStaticList().firstWhereOrNull((e) => e.phone == callController.text),
        phone: callController.text,
        occurrence: DateTime.now(),
        state: 1,
      )
          .whenComplete(() {
        context.pop();
        context.go(Paths.recents);
      });
    },
    child: Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.call_outlined, color: Colors.white),
          ),
          Text('Call', style: styleH3.copyWith(color: Colors.white)),
        ],
      ),
    ),
  );
}
