import 'package:call_app/resources/constants.dart';
import 'package:call_app/router/paths.dart';

Widget createNewContactWidget(BuildContext context) {
  return SizedBox(
    height: 40,
    child: TextButton(
      onPressed: () => context.push(Paths.newContact),
      child: const Row(
        children: [
          Icon(
            Icons.person_add_alt_outlined,
            color: darkAccentColor,
            size: 25,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Create new contact',
              style: TextStyle(
                fontSize: 20,
                color: darkAccentColor,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
