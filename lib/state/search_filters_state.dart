import 'package:call_app/models/filters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:call_app/models/filters.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

class FiltersBloc extends Cubit<Filters> {
  FiltersBloc({required this.filters}) : super(Filters.empty());
  final Filters filters;

  void clear() => emit(Filters.empty());

  void setName(String value) => emit(Filters(phone: filters.phone, name: value));

  void setPhone(String value) => emit(Filters(phone: value, name: filters.name));
}
