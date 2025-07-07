import 'package:labor_management_system/config/theme/colors/dark_colors.dart';
import 'package:labor_management_system/config/theme/colors/light_colors.dart';
import 'package:labor_management_system/config/theme/theme_engine/domain/usecase/get_theme_configuration_use_case.dart';
import 'package:labor_management_system/config/theme/theme_engine/theme_engine.dart';
import 'package:labor_management_system/config/translation/engine/domain/use_case/get_translations_use_case.dart';
import 'package:labor_management_system/config/translation/engine/translation_engine.dart';
import 'package:labor_management_system/config/translation/translations/en.dart';
import 'package:labor_management_system/config/translation/translations/ur.dart';
import 'package:labor_management_system/core/constants/api_constants/api_constants.dart';
import 'package:labor_management_system/core/constants/app_constants/app_constants.dart';
import 'package:labor_management_system/core/constants/database_keys/storage_keys.dart';

import '../../../config/providers/app_providers.dart';
import '../../../config/theme/app_colors/app_colors.dart';
import '../../../config/translation/app_text_styles/app_text_styles.dart';
import '../../app_assets/app_icons.dart';
import '../../constants/app_colors_keys/app_colors_keys.dart';
import '../../constants/app_keys/app_keys.dart';
import '../../constants/app_semantics/app_semantics.dart';
import '../../constants/app_translations_keys/app_translation_keys.dart';
import '../../injectors/injector.dart';
import '../../services/fcm_service/fcm_service.dart';

// Define all your helper getters for the injector here

/// This file contains a series of getter methods that provide access to various
/// injected dependencies using a dependency injection framework. Each getter
/// method retrieves a specific type of dependency from the injector, making it
/// available for use throughout the application.
///
/// The injected dependencies include:
///
/// - `AppConstants`: Provides App-related constants.
/// - `AppKeys`: Provides application keys.
///
///
///
AppProviders get injectedAppProviders => injector<AppProviders>();

AppKeys get injectedAppKeys => injector<AppKeys>();

StorageKeys get injectedStorageKeys => injector<StorageKeys>();

AppColorKeys get injectedAppColorKeys => injector<AppColorKeys>();

AppColors get injectedAppColors => injector<AppColors>();

AppTranslationKeys get injectedAppTranslationKeys =>
    injector<AppTranslationKeys>();

AppIcons get injectedAppIcons => injector<AppIcons>();

AppConstants get injectedAppConstant => injector<AppConstants>();
ApiConstants get injectedApiConstant => injector<ApiConstants>();

AppSemantics get injectedAppSemantics => injector<AppSemantics>();

FCMService get injectedFCMService => injector<FCMService>();

//---------------------------THEME---------------------------------

LightColors get injectedLightColors => injector<LightColors>();

DarkColors get injectedDarkColors => injector<DarkColors>();

ThemeEngine get injectedThemeEngine => injector<ThemeEngine>();

//--------------------------TRANSLATION---------------------------

English get injectedEnglish => injector<English>();

Urdu get injectedUrdu => injector<Urdu>();

TranslationEngine get injectedTranslationEngine =>
    injector<TranslationEngine>();

AppTextStyles get injectedAppTextStyles => injector<AppTextStyles>();

//---------------------------USE-Cases-----------------------------

GetThemeConfigurationUseCase get injectedThemeConfigUseCase =>
    injector<GetThemeConfigurationUseCase>();

GetTranslationsUseCase get injectedTranslationUseCase =>
    injector<GetTranslationsUseCase>();
