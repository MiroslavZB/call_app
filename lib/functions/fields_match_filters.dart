import 'package:call_app/models/filters.dart';

bool fieldsMatchFilters({
  required String? name,
  required String phone,
  required Filters filters,
}) {
  if (filters.isEmpty) return true;
  if (filters.name.isNotEmpty) {
    return name?.toLowerCase().contains(filters.name) ?? false;
  }
  if (filters.phone.isNotEmpty) {
    return phone.contains(filters.phone);
  }
  return false;
}
