import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:call_app/router/paths.dart';
import 'package:call_app/state/image_picker_state.dart';
import 'package:image_picker/image_picker.dart';

Future<void> pickImage(ImageSource source, BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: source);
  if (image != null) {
    final Uint8List bytes = File(image.path).readAsBytesSync();
    String base64Image = base64Encode(bytes);
    if (context.mounted) BlocProvider.of<ImagePickerState>(context).set(base64Image);
  }
}
