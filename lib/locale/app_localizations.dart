import 'package:booking_system_flutter/locale/language_ar.dart';
import 'package:booking_system_flutter/locale/language_en.dart';
import 'package:booking_system_flutter/locale/language_hi.dart';
import 'package:booking_system_flutter/locale/languages.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'languages_af.dart';
import 'languages_de.dart';
import 'languages_es.dart';
import 'languages_fr.dart';
import 'languages_gu.dart';
import 'languages_id.dart';
import 'languages_nl.dart';
import 'languages_pt.dart';
import 'languages_sq.dart';
import 'languages_tr.dart';
import 'languages_vi.dart';

class AppLocalizations extends LocalizationsDelegate<BaseLanguage> {
  const AppLocalizations();

  @override
  Future<BaseLanguage> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'ar':
        return LanguageAr();
      case 'hi':
        return LanguageHi();
      case 'gu':
        return LanguageGu();
      case 'af':
        return LanguageAf();
      case 'nl':
        return LanguageNl();
      case 'fr':
        return LanguageFr();
      case 'de':
        return LanguageDe();
      case 'id':
        return LanguageId();
      case 'es':
        return LanguageEs();
      case 'tr':
        return LanguageTr();
      case 'vi':
        return LanguageVi();
      case 'pt':
        return LanguagePt();
      case 'sq':
        return LanguageSq();

      default:
        return LanguageEn();
    }
  }

  @override
  bool isSupported(Locale locale) => LanguageDataModel.languages().contains(locale.languageCode);

  @override
  bool shouldReload(LocalizationsDelegate<BaseLanguage> old) => false;
}
