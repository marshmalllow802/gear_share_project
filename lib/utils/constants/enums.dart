enum PostCategory {
  books,
  vehicles,
  clothing,
  tools,
  others,
}

enum SortOption {
  byPriceAscending,
  byPriceDiscending,
  byLocation,
  byNewes,
}

enum FilterOption { byCategory, byRange, byRentalPeriod, byLocation }

enum MessageStatus {
  sent,
  delivered,
  read,
}

enum PostStatus {
  active,
  rented,
  deleted,
}

enum RentalPeriod {
  oneDay('Za dzień'),
  oneWeek('Za tydzień'),
  oneMonth('Za miesiąc'),
  custom('Niestandardowy');

  final String displayName;

  const RentalPeriod(this.displayName);

  // Konwersja z String (z Firebase) na RentalPeriod
  static RentalPeriod fromString(String value) {
    return RentalPeriod.values.firstWhere(
      (e) => e.toString() == value,
      orElse: () => RentalPeriod.oneDay,
    );
  }

  // Konwersja RentalPeriod na displayName
  @override
  String toString() => displayName;
}

enum TextSizes { small, medium, large }
