import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_common/locale/common_localizations.dart';

class CommonLocalizationDelegate extends LocalizationsDelegate<CommonLocalizations>{

  const CommonLocalizationDelegate();
  
  @override
  bool isSupported(Locale locale) {
    return ["zh","ja","en"].contains(locale.languageCode);
  }

  @override
  Future<CommonLocalizations> load(Locale locale) {
    return SynchronousFuture<CommonLocalizations>(CommonLocalizations(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<CommonLocalizations> old) {
    return false;
  }

  static CommonLocalizationDelegate delegate = const CommonLocalizationDelegate();
  
}