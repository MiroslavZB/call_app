import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

class SharedBoolState extends Cubit<bool> {
  SharedBoolState([this.initialState]) : super(initialState ?? false);
  final bool? initialState;

  void flip() => emit(!state);
}
