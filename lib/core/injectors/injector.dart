import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart' show DeviceInfoPlugin;
import 'package:firebase_messaging/firebase_messaging.dart'
    show FirebaseMessaging;
import 'package:flutter/services.dart' show MethodChannel;
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:labor_management_system/config/translation/app_text_styles/app_text_styles.dart';
import 'package:labor_management_system/config/translation/engine/data/repositories/translations_repository_impl.dart';
import 'package:labor_management_system/config/translation/engine/domain/repositories/translations_repository.dart';
import 'package:labor_management_system/config/translation/engine/domain/use_case/get_translations_use_case.dart';
import 'package:labor_management_system/config/translation/engine/translation_engine.dart';
import 'package:labor_management_system/config/translation/translations/ur.dart';
import 'package:labor_management_system/core/app_assets/app_icons.dart';
import 'package:labor_management_system/core/constants/api_constants/api_constants.dart';
import 'package:labor_management_system/core/constants/database_keys/storage_keys.dart';
import 'package:labor_management_system/core/data/data_source/remote/supabase_client/supa_base_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/providers/app_providers.dart';
import '../../config/router/app_router.dart';
import '../../config/theme/app_colors/app_colors.dart';
import '../../config/theme/colors/dark_colors.dart';
import '../../config/theme/colors/light_colors.dart';
import '../../config/theme/theme_engine/data/repositories/theme_configuration_repository_impl.dart';
import '../../config/theme/theme_engine/domain/repositories/theme_configuration_repository.dart';
import '../../config/theme/theme_engine/domain/usecase/get_theme_configuration_use_case.dart';
import '../../config/theme/theme_engine/theme_engine.dart';
import '../../config/translation/translations/en.dart';
import '../app_assets/app_translations.dart';
import '../constants/app_colors_keys/app_colors_keys.dart';
import '../constants/app_constants/app_constants.dart';
import '../constants/app_keys/app_keys.dart';
import '../constants/app_semantics/app_semantics.dart';
import '../constants/app_translations_keys/app_translation_keys.dart';
import '../services/connectivity_service/connectivity_service.dart';
import '../services/device_details_service/device_details_service.dart';
import '../services/fcm_service/fcm_service.dart';
import '../services/firebase_services/remote_config_service.dart';
import '../services/security_service/security_service.dart';
import '../services/storage_services/storage_service.dart';

///
/// GetIt instance to be used as a service locator
///
final injector = GetIt.I;

Future<void> initDependencies() async {
  /* -------------------------------------------------------------------------- */
  /*                                  CONSTANTS                                 */
  /* -------------------------------------------------------------------------- */

  injector.registerSingleton<AppKeys>(AppKeys());
  injector.registerSingleton<StorageKeys>(StorageKeys());
  injector.registerSingleton<AppSemantics>(AppSemantics());
  injector.registerSingleton<AppTranslationKeys>(AppTranslationKeys());
  injector.registerSingleton<AppColorKeys>(AppColorKeys());

  injector.registerSingleton<AppIcons>(AppIcons());
  injector.registerSingleton<AppColors>(AppColors());
  injector.registerSingleton<AppConstants>(AppConstants());
  injector.registerSingleton<ApiConstants>(ApiConstants());
  injector.registerSingleton<AppTranslations>(AppTranslations());

  /* -------------------------------------------------------------------------- */
  /*                         Storage Services                                   */
  /* -------------------------------------------------------------------------- */

  injector.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
  // Create the storage service
  final secureStorage = StorageService(
    //storage: injector<FlutterSecureStorage>(),
    preferences: injector<SharedPreferences>(),
  );
  // Initialize the cache
  injector.registerSingleton<StorageService>(secureStorage);

  /* -------------------------------------------------------------------------- */
  /*                                    THEME                                   */
  /* -------------------------------------------------------------------------- */
  injector.registerSingleton<LightColors>(LightColors());
  injector.registerSingleton<DarkColors>(DarkColors());

  injector.registerSingleton<ThemeEngine>(
    ThemeEngine(
      darkColors: injector<DarkColors>(),
      lightColors: injector<LightColors>(),
      storageKeys: injector<StorageKeys>(),
      storageService: injector<StorageService>(),
      appKeys: injector<AppKeys>(),
    ),
  );

  /* -------------------------------------------------------------------------- */
  /*                                TRANSLATIONS                                */
  /* -------------------------------------------------------------------------- */
  injector.registerSingleton<English>(English());
  injector.registerSingleton<Urdu>(Urdu());

  injector.registerSingleton<TranslationEngine>(
    TranslationEngine(
      storageService: injector<StorageService>(),
      appTranslations: injector<AppTranslations>(),
      storageKeys: injector<StorageKeys>(),
      appConstants: injector<AppConstants>(),
    ),
  );

  injector.registerSingleton<AppTextStyles>(
    AppTextStyles(
      translationEngine: injector<TranslationEngine>(),
      themeEngine: injector<ThemeEngine>(),
      appColors: injector<AppColors>(),
    ),
  );

  /* -------------------------------------------------------------------------- */
  /*                                  SERVICES                                  */
  /* -------------------------------------------------------------------------- */

  injector.registerSingleton<RemoteConfigService>(
    RemoteConfigService()..initialized(),
  );
  injector.registerSingleton<SupaBaseClient>(SupaBaseClient()..initSupaBase());


  injector.registerSingleton<FCMService>(
    FCMService(firebaseMessaging: FirebaseMessaging.instance),
  );

  /* -------------------------------------------------------------------------- */
  /*                                DEPENDENCIES                                */
  /* -------------------------------------------------------------------------- */
  injector.registerSingleton<MethodChannel>(
    MethodChannel(injector<AppKeys>().callMethodChannel),
  );

  injector.registerSingleton<JailbreakRootDetection>(JailbreakRootDetection.instance);
  injector.registerSingleton<Connectivity>(Connectivity());
  injector.registerSingleton<InternetConnectionChecker>(InternetConnectionChecker.instance);

  injector.registerSingleton<ConnectivityService>(
    ConnectivityService(
      connectivity: injector<Connectivity>(),
      internetConnectionChecker: injector<InternetConnectionChecker>(),
    ),
  );

  /* -------------------------------------------------------------------------- */
  /*                                  SECURITY                                  */
  /* -------------------------------------------------------------------------- */
  injector.registerSingleton<SecurityService>(
    SecurityService(
      jailbreakRootDetection: injector<JailbreakRootDetection>(),
      methodChannel: injector<MethodChannel>(),
    ),
  );


  /* -------------------------------------------------------------------------- */
  /*                                REPOSITORIES                                */
  /* -------------------------------------------------------------------------- */
  injector.registerSingleton<ThemeConfigurationRepository>(
    ThemeConfigurationRepositoryImpl(
      remoteConfigService: injector<RemoteConfigService>(),
    ),
  );

  injector.registerSingleton<TranslationsRepository>(
    TranslationsRepositoryImpl(
      remoteConfigService: injector<RemoteConfigService>(),
    ),
  );

  /* -------------------------------------------------------------------------- */
  /*                                  USE-CASES                                 */
  /* -------------------------------------------------------------------------- */
  injector.registerSingleton<GetThemeConfigurationUseCase>(
    GetThemeConfigurationUseCase(
      themeRepo: injector<ThemeConfigurationRepository>(),
    ),
  );

  injector.registerSingleton<GetTranslationsUseCase>(
    GetTranslationsUseCase(
      translationsRepository: injector<TranslationsRepository>(),
    ),
  );
  /* -------------------------------------------------------------------------- */
  /*                                 APP                                        */
  /* -------------------------------------------------------------------------- */

  injector.registerSingleton<AppRouter>(AppRouter());

  injector.registerSingleton<DeviceInfoPlugin>(DeviceInfoPlugin());
  injector.registerSingleton(
    DeviceDetailsService(
      deviceInfo: injector<DeviceInfoPlugin>(),
      methodChannel: injector<MethodChannel>(),
      appKeys: injector<AppKeys>(),
    ),
  );

  injector.registerSingleton<AppProviders>(
    AppProviders(),
  );

}
