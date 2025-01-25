enum PostCategory {
  books,
  vehiles,
  clothing,
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
  oneDay,
  oneWeek,
  oneMonth,
  custom,
}

enum TextSizes { small, medium, large }
