import 'package:call_app/functions/pick_image.dart';
import 'package:call_app/resources/constants.dart';
import 'package:call_app/router/paths.dart';
import 'package:image_picker/image_picker.dart';

Widget imagePickerWidget(
  BuildContext context, {
  required ImageSource source,
  required IconData iconData,
  required String text,
}) {
  return ElevatedButton(
    onPressed: () {
      context.pop();
      pickImage(source, context);
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: darkAccentColor,
    ),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(
            iconData,
            color: Colors.white,
          ),
        ),
        Text(
          text,
          style: styleH5.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
