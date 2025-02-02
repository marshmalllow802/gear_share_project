class KValidator {
  static String? validateEmptyText(String? value) {
    if (value == null || value.isEmpty) {
      return 'To pole jest wymagane.';
    }
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email jest wymagany.';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Błędny adres mailowy.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Hasło jest wymagane.';
    }

    if (value.length < 6) {
      return 'Hasło ma być dłuższe nić 6 znaków.';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Hasło musi zawierać przynajmniej jedną duża literkę.';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Hasło musi posiadać przynajmniej jedną cyfrę';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Hasło musi posiadać przynajmniej jeden znak specjalny';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Numer telefonu jest wymagany';
    }

    final phoneRegExp = RegExp(r'^\d{9}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Nieprawidłowy format numeru telefonu(wymagane jest 9 cyfr)';
    }
    return null;
  }
}
