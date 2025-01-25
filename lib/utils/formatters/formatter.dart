import 'package:intl/intl.dart';

class KFormatter {
  // Formatowanie daty
  static String formatDate(DateTime? date) {
    date ??= DateTime.now(); // Użyj obecnej daty, jeśli nie podano
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  // Formatowanie waluty
  static String formatCurrency(double amount,
      {String locale = 'pl_PL', String symbol = 'zł'}) {
    return NumberFormat.currency(locale: locale, symbol: symbol).format(amount);
  }

  // Formatowanie numeru telefonu
  static String formatPhoneNumber(String phoneNumber) {
    // Dla polskich numerów telefonów (np. +48 123 456 789)
    if (phoneNumber.length == 9) {
      return '${phoneNumber.substring(0, 3)} ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '${phoneNumber.substring(0, 2)} ${phoneNumber.substring(2, 5)} ${phoneNumber.substring(5, 8)} ${phoneNumber.substring(8)}';
    }
    return phoneNumber; // Zwróć numer bez zmian, jeśli format jest inny
  }

  // Formatowanie czasu w relatywnej formie ("2 dni temu")
  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays >= 1) {
      return '${difference.inDays} dni temu';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} godzin temu';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minut temu';
    } else {
      return 'przed chwilą';
    }
  }

  static String formatAddress(String address) {
    // Usunięcie zbędnych białych znaków i poprawienie formatowania
    return address.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  // Formatowanie odległości (metry na kilometry)
  static String formatDistance(double distanceInMeters) {
    if (distanceInMeters >= 1000) {
      return '${(distanceInMeters / 1000).toStringAsFixed(1)} km';
    } else {
      return '${distanceInMeters.toStringAsFixed(0)} m';
    }
  }

  // Skracanie tekstu do określonej długości
  static String truncateText(String text, int maxLength) {
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    }
    return text;
  }

  // Formatowanie cen na dzień (np. "10 zł/dzień")
  static String formatPricePerDay(double price,
      {String locale = 'pl_PL', String symbol = 'zł'}) {
    return '${formatCurrency(price, locale: locale, symbol: symbol)}/dzień';
  }

  // Ocena użytkownika
  static String formatRating(double rating) {
    return '${rating.toStringAsFixed(1)} / 5.0';
  }

  static String formatAdStatus(String status) {
    switch (status) {
      case 'available':
        return 'Dostępne';
      case 'reserved':
        return 'Zarezerwowane';
      case 'rented':
        return 'Wypożyczone';
      default:
        return 'Nieznany status';
    }
  }
}
