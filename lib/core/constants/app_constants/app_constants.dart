import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConstants {
  /* -------------------------------------------------------------------------- */
  /*                           APP CONSTANTS                                    */
  /* -------------------------------------------------------------------------- */

  /// Name of the app
  final String appName = "Nuevo";

  /// App version
  final String appVersion = "1.0.0";

  /// User type for the app
  final String userType = 'customer';

  /// Whether the app is in development mode
  final bool isDevEnvEnabled = true;

  /// runtime app tokens
  /// Fcm token
  String fcmToken = '';

  /* -------------------------------------------------------------------------- */
  /*                           LOCALIZATION CONSTANTS                           */
  /* -------------------------------------------------------------------------- */

  /// Default language direction
  final String defaultLanguageDirection = 'ltr';

  /// Default language key
  final String defaultLanguageKey = 'en';

  /// Default language label
  final String defaultLanguageLabel = 'English';

  /* -------------------------------------------------------------------------- */
  /*                            ENVIRONMENT CONSTANTS                           */
  /* -------------------------------------------------------------------------- */

  /// Dev environment checks
  final Map<String, dynamic> _devEnvChecks = {
    'enableJailBreakOrRootedDeviceDetection': false,
    'enableEmulatorDetection': false,
    //'enableVpnDetection': false,
    //'hyperPluginMode': Modes.TEST,
    //'nearPayMode': Environments.sandbox,
    // 'enableFingerPrintScan': false,
    'enableCrashlytics': false,
    'checkForCertificate': false,
    'enableHashing': false,
  };

  /// Prod environment checks
  final Map<String, dynamic> _prodEnvChecks = {
    'enableJailBreakOrRootedDeviceDetection': true,
    'enableEmulatorDetection': true,
    // 'enableVpnDetection': true,
    //'hyperPluginMode': Modes.LIVE,
    //'nearPayMode': Environments.sandbox,
    //'enableFingerPrintScan': true,
    'enableCrashlytics': true,
    'checkForCertificate': true,
    'enableHashing': false,
  };

  /* -------------------------------------------------------------------------- */
  /*                                   GETTERS                                  */
  /* -------------------------------------------------------------------------- */

  /* ----------------------------------- UI ----------------------------------- */

  /// Default screen padding
  double get defaultScreenPadding => 20.0.w;

  /* ------------------------------- ENVIRONMENT ------------------------------ */

  /// Whether jailbreak or rooted Device detection is enabled according to the environment
  bool get enableJailBreakOrRootedDeviceDetection => isDevEnvEnabled
      ? _devEnvChecks['enableJailBreakOrRootedDeviceDetection']
      : _prodEnvChecks['enableJailBreakOrRootedDeviceDetection'];

  /// Whether emulator detection is enabled according to the environment
  bool get enableEmulatorDetection => isDevEnvEnabled
      ? _devEnvChecks['enableEmulatorDetection']
      : _prodEnvChecks['enableEmulatorDetection'];
}
