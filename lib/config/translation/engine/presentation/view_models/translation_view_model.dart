import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:labor_management_system/core/utils/injector_utils/injector_helper.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/global_utils/global_utils.dart'
    show navigatorKey;

class TranslationViewModel extends ChangeNotifier {
  TranslationViewModel() {
    _initViewModel();
  }

  /* -------------------------------------------------------------------------- */
  /*                                  VARIABLES                                 */
  /* -------------------------------------------------------------------------- */

  /// [localeNotifier] is a [ValueNotifier] that holds the current locale of the app
  late ValueNotifier<Locale> localeNotifier;

  /* -------------------------------------------------------------------------- */
  /*                                   METHODS                                  */
  /* -------------------------------------------------------------------------- */

  /// Initialize the view model with the required data
  void _initViewModel() {
    localeNotifier = ValueNotifier(injectedTranslationEngine.activeLocale);
  }

  ///
  /// Change the locale of the app to the given [locale]
  ///
  void changeLocale(Locale locale) {
    localeNotifier.value = locale;
  }

  /* --------------------------------- GETTERS -------------------------------- */

  /// Get the current locale of the app
  Locale get currentLocale => injectedTranslationEngine.activeLocale;

  /// Get the localizations delegates of the app
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates => const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  /// Get the supported locales of the app for the user to choose from
  List<Locale> get supportedLocales => [
    Locale(injectedAppKeys.en, injectedAppKeys.usCountryCode),
    Locale(injectedAppKeys.ur, injectedAppKeys.pkCountryCode),
  ];

  ///
  /// Static getter to get the [TranslationViewModel] instance
  ///
  static TranslationViewModel of({bool listen = false}) =>
      Provider.of<TranslationViewModel>(
        navigatorKey.currentContext!,
        listen: listen,
      );
}
