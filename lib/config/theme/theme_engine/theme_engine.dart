import 'package:flutter/material.dart';
import 'package:labor_management_system/config/theme/theme_engine/domain/entities/light_theme_icon_pack_entity.dart';
import 'package:labor_management_system/config/theme/theme_engine/domain/entities/theme_icon_entity.dart';
import 'package:labor_management_system/core/constants/app_keys/app_keys.dart';
import 'package:labor_management_system/core/constants/database_keys/storage_keys.dart';
import 'package:labor_management_system/core/type_defs/common_helper_types_type_defs.dart';
import 'package:labor_management_system/core/utils/injector_utils/injector_helper.dart';
import '../../../core/enums/icon_type.dart';
import '../../../core/services/storage_services/storage_service.dart'
    show StorageService;
import '../colors/dark_colors.dart';
import '../colors/light_colors.dart';
import 'domain/entities/dart_theme_icon_pack_entity.dart';
import 'domain/entities/theme_configuration_entity.dart';

class ThemeEngine {
  ThemeEngine({
    required DarkColors darkColors,
    required LightColors lightColors,
    required StorageService storageService,
    required StorageKeys storageKeys,
    required AppKeys appKeys,
  }) : _storageService = storageService,
       _storageKeys = storageKeys,
       _appKeys = appKeys {
    // Initialize the theme mode
    _initializeThemeMode();

    // Initialize the local icons
    _initializeLocalIcons();

    // Initialize the theme icons
    _initializeThemeIcons();
  }

  /* -------------------------------------------------------------------------- */
  /*                                  VARIABLES                                 */
  /* -------------------------------------------------------------------------- */

  ///
  /// Variable tracks the current theme mode of the application
  /// light or dark
  ///
  final ValueNotifier<bool> isDark = ValueNotifier(false);

  ///
  /// [_storageService] will be used to cache theme configuration in the local database.
  ///
  final StorageService _storageService;

  ///
  /// [_storageKeys] will give the storage keys used in the application
  ///
  final StorageKeys _storageKeys;

  ///
  /// [_appKeys] will give the app keys used in the application
  ///
  final AppKeys _appKeys;

  ///
  /// Theme configuration entity that holds the theme configurations
  /// coming from the api
  ///
  ThemeConfigurationEntity? _themeConfigurationEntity;

  ///
  /// Theme icons holder entity that holds the theme icons
  /// according to the theme mode
  ///
  ThemeIconsEntity? themeIconsEntity = ThemeIconsEntity();

  ///
  /// Active icon type (light or dark)
  ///
  IconType activeIconType = IconType.light;

  ///
  /// Dark theme icon pack entity that holds the dark theme icons
  /// paths loaded from assets
  ///
  DarkThemeIconPackEntity? _darkThemeIconPackEntity;

  ///
  /// Light theme icon pack entity that holds the light theme icons
  /// paths loaded from assets
  ///
  LightThemeIconPackEntity? _lightThemeIconsPackEntity;

  ///
  /// This private method mapping all of the available language's translations
  ///
  Map<String, MapStringDynamic> _localizedColorValues = {
    'dark': injectedDarkColors.darkColors,
    'light': injectedLightColors.lightColors,
  };

  /* -------------------------------------------------------------------------- */
  /*                                   METHODS                                  */
  /* -------------------------------------------------------------------------- */

  ///
  /// Initialize theme mode from storage
  ///
  void _initializeThemeMode() {
    // Getting the theme mode from the storage
    final String? activeThemeMode = _storageService.getString(
      _storageKeys.activeThemeMode,
    );
    isDark.value = activeThemeMode == null
        ? false
        : activeThemeMode == _appKeys.dark;

    if (activeThemeMode == null) {
      // Set if active theme is null
      _storageService.setString(
        _storageKeys.activeThemeMode,
        isDark.value ? _appKeys.dark : _appKeys.light,
      );
    }
  }

  ///
  /// Call the theme configuration api to get the theme configurations
  /// and initialize the theme colors and icons
  ///
  Future<void> getThemeConfiguration() async {
    final response = await injectedThemeConfigUseCase.call();

    _themeConfigurationEntity = response;
    if (_themeConfigurationEntity != null) {
      // Initializing the theme data
      _initializeThemeData();
    }
  }

  ///
  /// Initialize the theme data from the api
  ///
  void _initializeThemeData() {
    // Initialize the theme icons
    _initializeThemeIcons();

    _localizedColorValues = {
      _appKeys.dark: _themeConfigurationEntity?.dark?.colors ?? {},
      _appKeys.light: _themeConfigurationEntity?.light?.colors ?? {},
    };

    updateColorHashMap();
  }

  ///
  /// This method will update the theme mode
  ///
  void updateThemeMode({required bool isDarkMode}) {
    isDark.value = isDarkMode;
    updateColorHashMap();
    _storageService.setString(
      _storageKeys.activeThemeMode,
      isDarkMode ? _appKeys.dark : _appKeys.light,
    );
  }

  ///
  /// The key to get the colors from the local map
  ///
  String get _colorsKey => isDark.value ? _appKeys.dark : _appKeys.light;

  /// This method will give color against [key] from
  /// available hashmap of currently selected colors
  ///
  Color getColor(String key) => Color(
    int.parse(
      _localizedColorValues[_colorsKey]?[key] as String? ?? '0xFFFFFFFF',
    ),
  );

  ///
  /// This method will update local language/translations map
  ///
  void updateColorsHashMap({required Map<String, dynamic> newColorsMap}) =>
      _localizedColorValues[_colorsKey] = newColorsMap;

  /// Updates the color hash map based on the current theme mode (dark or light).
  ///
  /// This method checks the value of `isDark` to determine whether the dark mode
  /// is active. If dark mode is active, it retrieves the dark colors from the
  /// `_themeConfigurationEntity` or falls back to the default dark colors from
  /// the `DarkColors` injector. If dark mode is not active, it retrieves the light
  /// colors from the `_themeConfigurationEntity` or falls back to the default light
  /// colors from the `LightColors` injector.
  ///
  /// The retrieved colors are then passed to the `updateColorsHashMap` method to
  /// update the color hash map.
  void updateColorHashMap() {
    updateColorsHashMap(
      newColorsMap: isDark.value
          ? _themeConfigurationEntity?.dark?.colors ??
                injectedDarkColors.darkColors
          : _themeConfigurationEntity?.light?.colors ??
                injectedLightColors.lightColors,
    );

    // Initialize the theme icons
    _initializeThemeIcons();
  }

  ///
  /// Initialize the local icons in [themeIconsHolderEntity] and [themeIconsHolderEntity]
  /// from assets
  void _initializeLocalIcons() {
    //TODO: need to work on this, will use Assets gen
    // Getting the app icons from the injector
    //final appIcons = injectedAppIcons;

    // Creating the light theme icons pack entity
    _darkThemeIconPackEntity = DarkThemeIconPackEntity(
      appErrorAlertIcon: "",
      contractIcon: "",
      profileIcon: "",
      refreshIcon: "",
      registerIcon: "",
      settingsIcon: "",
      signOutIcon: "",
      workerIcon: "",
    );

    // Creating the light theme icons pack entity
    _lightThemeIconsPackEntity = LightThemeIconPackEntity(
      appErrorAlertIcon: "",
      contractIcon: "",
      profileIcon: "",
      refreshIcon: "",
      registerIcon: "",
      settingsIcon: "",
      signOutIcon: "",
      workerIcon: "",
    );
  }

  ///
  /// Initializes the theme colors in [themeIconsHolderEntity]
  /// according to the theme mode
  ///
  void _initializeThemeIcons() {
    themeIconsEntity = themeIconsEntity?.copyWith(
      appErrorAlertIcon: isDark.value
          ? _darkThemeIconPackEntity?.appErrorAlertIcon
          : _lightThemeIconsPackEntity?.appErrorAlertIcon,
      profileIcon: isDark.value
          ? _darkThemeIconPackEntity?.profileIcon
          : _lightThemeIconsPackEntity?.profileIcon,
      registerIcon: isDark.value
          ? _darkThemeIconPackEntity?.registerIcon
          : _lightThemeIconsPackEntity?.registerIcon,
      settingsIcon: isDark.value
          ? _darkThemeIconPackEntity?.settingsIcon
          : _lightThemeIconsPackEntity?.settingsIcon,
      signOutIcon: isDark.value
          ? _darkThemeIconPackEntity?.signOutIcon
          : _lightThemeIconsPackEntity?.signOutIcon,
      contractIcon: isDark.value
          ? _darkThemeIconPackEntity?.contractIcon
          : _lightThemeIconsPackEntity?.contractIcon,
      workerIcon: isDark.value
          ? _darkThemeIconPackEntity?.workerIcon
          : _lightThemeIconsPackEntity?.workerIcon,
      refreshIcon: isDark.value
          ? _darkThemeIconPackEntity?.registerIcon
          : _lightThemeIconsPackEntity?.refreshIcon,
    );
  }
}
