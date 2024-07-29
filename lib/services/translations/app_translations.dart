import 'package:get/get.dart';

import 'en_US/en_us_translations.dart';
import 'hi_IN/hi_in_translations.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': enUs,
        'hi': hiIn,
      };
}
