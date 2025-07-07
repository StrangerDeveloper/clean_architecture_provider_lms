import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:labor_management_system/core/utils/injector_utils/injector_helper.dart';

import '../../../core/app_assets/app_translations.dart';
import '../../../core/constants/app_constants/app_constants.dart';
import '../../../core/constants/database_keys/storage_keys.dart';
import '../../../core/services/storage_services/storage_service.dart';
import '../../../core/type_defs/localization_change.dart';
import 'data/models/localization_configuration_model.dart';
import 'domain/entities/localization_configuration_entity.dart';
import '../../../core/extensions/logs/log_ext.dart';

class TranslationEngine {
  ///
  /// Public constructor
  ///
  TranslationEngine({
    required StorageService storageService,
    required AppTranslations appTranslations,
    required StorageKeys storageKeys,
    required AppConstants appConstants,
  }) : _storageService = storageService,
       _appTranslations = appTranslations,
       _storageKeys = storageKeys,
       _appConstants = appConstants {
    // Get any previously selected language from storage and update
    _getPreviouslySelectedLanguageFromStorageAndUpdate();
  }

  /* -------------------------------------------------------------------------- */
  /*                                  VARIABLES                                 */
  /* -------------------------------------------------------------------------- */

  ///
  /// [_currentLanguage] is an object containing current [LanguageEntity], [LanguageEntity]
  /// is an object holding information of a particular language i.e.
  /// language name, language identifier & language direction etc.
  ///
  final ValueNotifier<LanguageEntity?> _currentLanguage = ValueNotifier(null);

  ///
  /// [_currentLanguageDirection] is an object containing current direction of
  /// selected language. Purpose of maintaining direction explicitly is to give
  /// listener to [TextDirection] of current language so that its client gets
  /// realtime updates of language direction whenever language changed
  ///
  final ValueNotifier<TextDirection> _currentLanguageDirection = ValueNotifier(
    TextDirection.ltr,
  );

  ///
  /// [_storageService] will be used to cache translations configuration in the local database.
  ///
  final StorageService _storageService;

  ///
  /// [_appTranslations] will give paths to local stubs
  ///
  final AppTranslations _appTranslations;

  ///
  /// [_storageKeys] will give the storage keys used in the application
  ///
  final StorageKeys _storageKeys;

  ///
  /// [_appConstants] will give all the app constants used in the application
  ///
  final AppConstants _appConstants;

  ///
  /// This private method mapping all of the available language's translations
  ///
  final Map<String, Map<String, dynamic>> _localizedValues = {
    'en': injectedEnglish.english,
    'ur': injectedUrdu.urdu,
  };

  ///
  /// [localizationConfigurationsEntity] will be used to hold the translations
  ///
  LocalizationConfigurationsEntity? localizationConfigurationsEntity;

  ///
  /// Variable to hold all the available languages
  /// i.e. English, Arabic etc.
  ///
  List<LanguageEntity>? languages;

  /* -------------------------------------------------------------------------- */
  /*                                   METHODS                                  */
  /* -------------------------------------------------------------------------- */

  ///
  /// This method will be responsible for getting any previously selected
  /// language from cache if present.
  ///
  /// Two of the variable will be updated using this method i.e.
  /// [_currentLanguage] & [_currentLanguageDirection].
  ///
  Future<void> _getPreviouslySelectedLanguageFromStorageAndUpdate() async {
    // Getting previously selected language from storage
    final String? selectedLanguageResponse = _storageService.getString(
      _storageKeys.selectedLanguage,
    );
    // Get default translations from the local stub
    final res = await Future.wait([
      _getLocalLanguageJson(),
      _getLocalLanguagesJson(),
    ]);

    // Converting the default language response json to map
    final parsedResponse = jsonDecode((selectedLanguageResponse ?? res[0]));

    // Setting current language, from the value we got from storage
    _currentLanguage.value = LanguageModel.fromJson(parsedResponse);

    // Converting the default languages response json to map
    final parsedLanguagesResponse = jsonDecode(res[1]);
    // Setting available languages
    languages = List<LanguageEntity>.from(
      parsedLanguagesResponse.map((x) => LanguageModel.fromJson(x)),
    );

    // after updating [_currentLanguage], update language direction as
    // well so that its listeners can be updated
    _currentLanguageDirection.value = _getTextDirectionByStringKey(
      _currentLanguage.value?.direction ??
          _appConstants.defaultLanguageDirection,
    );
    // Initialize local translations map
    updateLanguageHashMap(
      newLanguageMap:
          _currentLanguage.value?.value ==
              injectedAppConstant.defaultLanguageKey
          ? injectedEnglish.english
          : injectedUrdu.urdu,
    );
  }

  ///
  /// Load hardcoded stub for
  /// default language i.e. English which is present at the path:
  ///
  /// assets/translations/default_language_stub.json
  ///
  Future<String> _getLocalLanguageJson() async =>
      await rootBundle.loadString(_appTranslations.defaultLanguageStub);

  ///
  /// Load hardcoded stub for available languages which is present at the path:
  ///
  /// assets/translations/default_languages_stub.json
  ///
  Future<String> _getLocalLanguagesJson() async =>
      await rootBundle.loadString(_appTranslations.defaultLanguagesStub);

  ///
  /// This method will be responsible for changing/updating current language.
  ///
  /// First parameter [LanguageEntity] will be giving updated language data to the
  /// method while [OnLocalizationChanged] is a callback that will be listened
  /// by client to perform any action after process completion
  ///
  /// [firstTime] is a boolean parameter that will be used to check if the translations is
  /// being fetch for the first time
  ///
  Future<void> getAndChangeLanguage({
    LanguageEntity? languageEntity,
    OnLocalizationChanged? onLocalizationUpdated,
    bool firstTime = false,
    bool? shouldSaveInStorage = false,
  }) async {
    //
    bool isApiCalledSucceed = false;

    // Check if translations are being fetched for the first time, then we need to fetch from
    // the remote config
    if (firstTime) {
      // Call the get translations api
      isApiCalledSucceed = await _getTranslationFromRemoteConfig();
    }

    // Check if translations are fetched from api or language entity is not null
    if (isApiCalledSucceed || languageEntity != null) {
      // If translations are not fetched from api, then set the translations configurations
      // from the local stub
      _setTranslationsConfigurations(languageKey: languageEntity?.value);
    }

    if (languageEntity != null) {
      // Updating new language entity
      _currentLanguage.value = languageEntity;

      // Updating language direction
      _currentLanguageDirection.value = _getTextDirectionByStringKey(
        languageEntity.direction ?? _appConstants.defaultLanguageKey,
      );
    }

    if (shouldSaveInStorage!) {
      // Save the selected language in storage
      _storageService.setString(
        _storageKeys.selectedLanguage,
        jsonEncode((languageEntity as LanguageModel?)?.toJson()),
      );
    }

    ///
    /// Invoke [OnLocalizationUpdated] callback to tell listeners that,
    /// language has been updated
    ///
    if (onLocalizationUpdated != null) {
      onLocalizationUpdated(languageEntity, activeLocale);
    }
  }

  ///
  /// Get translations from the API
  /// returns true if translations are fetched successfully
  ///
  Future<bool> _getTranslationFromRemoteConfig() async {
    try {
      // Calling the translations remote Config use case
      final response = await injectedTranslationUseCase.call();

      // Checking if the response is successful and data is not null
      if (response != null) {
        localizationConfigurationsEntity = response;
        return true;
      } else {
        "Error: Languages and configuration are not fetched".logs();
      }
    } catch (e) {
      "Error: $e".logs();
    }

    return false;
  }

  ///
  /// This method will set the initial translations configurations if translations are loaded from api
  ///
  void _setTranslationsConfigurations({String? languageKey}) {
    // Get the active configurations from the translations api
    final configurations = getActiveConfigurations(
      languageKey: languageKey ?? this.languageKey,
    );

    // Update the language hash map
    updateLanguageHashMap(
      newLanguageMap: configurations?.configurations ?? {},
      languageKey: languageKey,
    );
  }

  ///
  /// Get the active language configuration entity according to the language key
  /// i.e. `en` for English and `ar` for Arabic
  ///
  ConfigurationEntity? getActiveConfigurations({required String languageKey}) {
    return (localizationConfigurationsEntity?.configurations ??
            getLocalConfigurations())
        .where((element) => element.code == languageKey)
        .first;
  }

  ///
  /// This method will give all the available local configurations
  ///
  List<ConfigurationEntity> getLocalConfigurations() => [
    ConfigurationEntity(code: 'en', configurations: injectedEnglish.english),
    ConfigurationEntity(code: 'ar', configurations: injectedUrdu.urdu),
  ];

  ///
  /// This method will give translation against [key] from
  /// available hashmap of currently selected language
  ///
  String getTranslation(String key, [String? langKey]) =>
      _localizedValues[langKey ?? languageKey]?[key] ?? key;

  ///
  /// This method will update local language/translations map
  ///
  void updateLanguageHashMap({
    required Map<String, dynamic> newLanguageMap,
    String? languageKey,
  }) => _localizedValues[languageKey ?? this.languageKey] = newLanguageMap;

  ///
  /// method responsible for returning TextDirection from string keys [ltr, rtl]
  ///
  TextDirection _getTextDirectionByStringKey(String key) =>
      key == "ltr" ? TextDirection.ltr : TextDirection.rtl;

  ///
  /// This getter will give language key of currently selected language i.e.
  /// `en` for English and `ar` for Arabic
  ///
  String get languageKey =>
      _currentLanguage.value?.value ?? _appConstants.defaultLanguageKey;

  ///
  /// This getter will return name of currently selected i.e. `English` for
  /// english & `Urdu` for urdu
  ///
  String get selectedLanguageLabel =>
      _currentLanguage.value?.label ?? _appConstants.defaultLanguageLabel;

  ///
  /// This getter will return [Locale] of currently selected language
  ///
  Locale get activeLocale => Locale(
    languageKey == _appConstants.defaultLanguageKey
        ? injectedAppKeys.en
        : injectedAppKeys.ar,
    languageKey == _appConstants.defaultLanguageKey
        ? injectedAppKeys.usCountryCode
        : injectedAppKeys.pkCountryCode,
  );

  ///
  /// This getter will return [TextDirection]'s [ValueNotifier]
  ///
  ValueNotifier<TextDirection> get selectedLanguageDirection =>
      _currentLanguageDirection;

  ///
  /// This getter will return complete object of currently selected language
  ///
  LanguageEntity? get selectedLanguage => _currentLanguage.value;
}
