class UserFilter {
  final String? name;
  final List<String>? location;
  final DateTime? year;

  const UserFilter({this.name, this.location, this.year});

  UserFilter copyWith({String? name, List<String>? location, DateTime? year}) {
    return UserFilter(
      name: name ?? this.name,
      location: location ?? this.location,
      year: year ?? this.year,
    );
  }

  bool get isEmpty => name == null && location == null && year == null;
}
