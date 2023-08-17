class Filters {
  final String phone;
  final String name;
  Filters({required this.phone, required this.name});

  factory Filters.empty() => Filters(phone: '', name: '');

  bool get isEmpty => phone.isEmpty && name.isEmpty;
}
