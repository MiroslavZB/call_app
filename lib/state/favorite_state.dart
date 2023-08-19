import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Cubit<bool> {
  FavoriteBloc(bool initialState) : super(initialState);

  void flip() => emit(!state);
}
