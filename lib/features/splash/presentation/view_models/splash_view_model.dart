import 'package:flutter/material.dart';
import 'package:labor_management_system/core/extensions/logs/log_ext.dart';
import 'package:labor_management_system/core/extensions/theme_color/theme_color_ext.dart';
import 'package:labor_management_system/core/extensions/translation_ext/translation_ext.dart';

import '../../../../core/injectors/injector.dart';
import '../../../../core/services/connectivity_service/connectivity_service.dart';
import '../../../../core/services/device_details_service/device_details_service.dart';
import '../../../../core/services/security_service/security_service.dart';
import '../../../../core/utils/injector_utils/injector_helper.dart';
import '../../../../core/utils/show_bottom_sheet_utils/show_bottom_sheet_utils.dart';
import '../../../dashboard/presentation/view_models/dashboard_view_model.dart';
import '../../domain/use_case/verify_version_use_case.dart';

class SplashViewModel extends ChangeNotifier {
  SplashViewModel({required this.dashboardViewModel}) {
    _handleSecurityChecks();
  }

  /* -------------------------------------------------------------------------- */
  /*                                  VARIABLES                                 */
  /* -------------------------------------------------------------------------- */

  /// [dashboardViewModel] instance to hold the dashboard data
  final DashboardViewModel dashboardViewModel;

  /* -------------------------------------------------------------------------- */
  /*                                   METHODS                                  */
  /* -------------------------------------------------------------------------- */

  ///
  /// Method to handle the security checks
  /// - Check if the device is jail broken or rooted
  /// - Check if the device is running on an emulator
  ///

  Future<void> _handleSecurityChecks() async {
    // Initialize the connectivity service
    injector<ConnectivityService>().initConnectivityService();
    final bool isJailBrokenOrRooted = await injector<SecurityService>()
        .isJailBrokenAndRooted();

    'isJailBrokenOrRooted: $isJailBrokenOrRooted'.logs();

    if (isJailBrokenOrRooted) {
      // Handle jail broken or rooted device
      showCustomBottomSheet(
        title: injectedAppTranslationKeys.rootedDevice.translate,
        isDismissible: false,
        hideBothButtons: true,
        description: injectedAppTranslationKeys.yourDeviceIsRooted.translate,
        iconColor: injectedAppColorKeys.secondaryColor.themeColor,
      );

      return;
    }

    final bool isEmulator = await injector<SecurityService>().isEmulator();
    'isEmulator: $isEmulator'.logs();

    if (isEmulator) {
      // Handle emulator device
      showCustomBottomSheet(
        title: injectedAppTranslationKeys.emulatorDevice.translate,
        isDismissible: false,
        hideBothButtons: true,
        description: injectedAppTranslationKeys
            .yourDeviceIsRunningOnAnEmulator
            .translate,
        iconColor: injectedAppColorKeys.secondaryColor.themeColor,
      );

      return;
    }

    //init and get device details
    // get fcm token
    // call for version api.
    await injector<DeviceDetailsService>().getDeviceDetails();
    await _getFcmToken();
    _callVersionCheckApi();
  }

  //ture<void> _checkForLocationServicesAndNeededApiCalls() async {
    // Initialize device details dependency

    //TODO: this functionality is shifted to dashboard screen
//  }

  ///
  /// Call the version check api and navigate to the login screen
  ///
  void _callVersionCheckApi() async {
    // Call the verify version api to check the app version
    final bool isVersionValid = await verifyAppVersion();
    // Check if the version is valid, call the needed api's
    if (isVersionValid) {
      await Future.wait([
        injectedThemeEngine.getThemeConfiguration(),
        injectedTranslationEngine.getAndChangeLanguage(firstTime: true),
      ]);
    }

    //TODO: Decide to move either to dashboard or login screen.
    // Navigate to Login Screen
    // Navigator.pushReplacementNamed(
    //   navigatorKey.currentContext!,
    //   //LoginScreen.id,
    // );
  }

  ///
  /// Call the verify version api to check the app version
  ///
  Future<bool> verifyAppVersion() async {
    try {
      // Calling the verify version api
      final result = await injector<VerifyVersionUseCase>().call(
        params: injectedAppConstant.appVersion,
      );

      if (result != null) {
        if (result.status == false) {
          // Handle jail broken or rooted device
          showCustomBottomSheet(
            title: injectedAppTranslationKeys.update.translate,
            hideBothButtons: true,
            description:
                injectedAppTranslationKeys.appVersionIsOutdated.translate,
            iconColor: injectedAppColorKeys.secondaryColor.themeColor,
          );

          return false;
        }

        return result.status == true;
      } else {
        'Error: Verify App Version is not successful'.logError();
      }
    } catch (e) {
      'Error: $e'.logs();
      showCustomBottomSheet(
        title: injectedAppTranslationKeys.error.translate,
        showSingleButton: true,
        description: e.toString(),
        primaryButtonText: injectedAppTranslationKeys.ok.translate,
      );
    }

    return false;
  }

  ///
  /// Method to get the FCM token from the FCM service and store it in the app constants
  ///
  Future<void> _getFcmToken() async {
    try {
      injectedAppConstant.fcmToken = await injectedFCMService.getFCMToken();
      'FCM Token: ======> ${injectedAppConstant.fcmToken}'.logs();
    } catch (e) {
      e.logError();
    }
  }
}
