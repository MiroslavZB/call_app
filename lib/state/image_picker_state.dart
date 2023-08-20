import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickerState extends Cubit<String?> {
  ImagePickerState() : super(null);

  void set(String? image) => emit(image);
}
