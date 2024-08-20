abstract class Validators {
  static const String urlPattern = r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
  static const String emailPattern = r'\S+@\S+';
  static const String phonePattern = r'[\d-]{9,}';

  static bool isValidUrl(String url) {
    if (RegExp(urlPattern, caseSensitive: false).hasMatch(url)) {
      return true;
    }
    return false;
  }

  static bool isValidEmail(String? inputString) {
    bool isInputStringValid = false;

    if ((inputString == null ? true : inputString.isEmpty)) {
      isInputStringValid = true;
    }

    if (inputString != null && inputString.isNotEmpty) {
      const pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      final regExp = RegExp(pattern);

      isInputStringValid = regExp.hasMatch(inputString);
    }

    return isInputStringValid;
  }
}
