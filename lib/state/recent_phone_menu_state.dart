import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

class RecentPhoneMenuState extends Cubit<bool> {
  RecentPhoneMenuState() : super(false);

  void flip() => emit(!state);
}
