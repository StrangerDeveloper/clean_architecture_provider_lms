import 'dart:async' show StreamSubscription;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:labor_management_system/core/extensions/logs/log_ext.dart';
import 'package:labor_management_system/core/extensions/navigator_ext/navigator_ext.dart';

import '../../enums/connectivity_type/connectivity_type.dart';
import '../../utils/global_utils/global_utils.dart';

class ConnectivityService {
  ConnectivityService({
    required Connectivity connectivity,
    required InternetConnectionChecker internetConnectionChecker,
  }) : _connectivity = connectivity,
       _internetConnectionChecker = internetConnectionChecker;

  /* -------------------------------------------------------------------------- */
  /*                                  VARIABLES                                 */
  /* -------------------------------------------------------------------------- */

  /// Connectivity instance for checking the network status
  final Connectivity _connectivity;

  /// Internet connection checker instance for checking the internet connection status
  final InternetConnectionChecker _internetConnectionChecker;

  /// Flag to check if the connectivity error bottom sheet is showing
  bool isShowingConnectivityError = false;

  /// Connectivity stream subscription to listen to the connectivity changes
  StreamSubscription<List<ConnectivityResult>>? connectivityStreamSubscription;

  /// Internet connection stream subscription to listen to the internet connection changes
  StreamSubscription<InternetConnectionStatus>?
  internetConnectionStreamSubscription;

  /* -------------------------------------------------------------------------- */
  /*                                   METHODS                                  */
  /* -------------------------------------------------------------------------- */

  /// Initialize the connectivity service
  void initConnectivityService() {
    'Initializing the connectivity service'.logs();

    // Setup the connectivity
    _setupConnectivity();
  }

  /// Setup the connectivity stream
  void _setupConnectivity() {
    // Initialize the connectivity stream
    connectivityStreamSubscription = _connectivity.onConnectivityChanged.listen(
      (connectivityResult) {
        'Connectivity result: $connectivityResult'.logs();
        if (connectivityResult.contains(ConnectivityResult.none)) {
          _showErrorSnackBar(ConnectivityType.internet);
        } else {
          _popConnectivityErrorSnackBar(ConnectivityType.internet);
        }
      },
    );
  }

  /// Method to show the connectivity error bottom sheet
  void _showErrorSnackBar(ConnectivityType connectivityType) {
    // Check if the connectivity error snack bar is already showing and connectivity type is internet
    // to avoid showing it again
    if (isShowingConnectivityError &&
        connectivityType == ConnectivityType.internet) {
      return;
    }

    // showCustomBottomSheet(
    //   title: connectivityType == ConnectivityType.internet
    //       ? injectedAppTranslationKeys.internetConnection.translate
    //       : injectedAppTranslationKeys.vpnConnection.translate,
    //   isDismissible: false,
    //   hideBothButtons: true,
    //   description: connectivityType == ConnectivityType.internet
    //       ? injectedAppTranslationKeys.pleaseCheckYourInternetConnectionAndTryAgain.translate
    //       : injectedAppTranslationKeys.kindlyDisconnectVpnToUseTheApp.translate,
    //   iconColor: injectedAppColorKeys.secondaryColor.themeColor,
    // );

    // Set the flag to true based on the connectivity type
    if (connectivityType == ConnectivityType.internet) {
      isShowingConnectivityError = true;
      'isShowingConnectivityErrorBottomSheet: $isShowingConnectivityError'
          .logs();
    }
  }

  /// Pop the connectivity error bottom sheet
  void _popConnectivityErrorSnackBar(ConnectivityType connectivityType) {
    // Check if the connectivity error bottom sheet is not showing and connectivity type is internet
    // to avoid popping it
    if (!isShowingConnectivityError &&
        connectivityType == ConnectivityType.internet) {
      return;
    }

    // Pop the bottom sheet
    navigatorKey.currentContext!.navigator.pop();

    // Set the flag to false based on the connectivity type
    if (connectivityType == ConnectivityType.internet) {
      isShowingConnectivityError = false;
      'isShowingConnectivityErrorBottomSheet: $isShowingConnectivityError'
          .logs();
    }
  }

  /// Dispose the connectivity service
  void dispose() {
    // Cancel the connectivity stream subscription
    connectivityStreamSubscription?.cancel();
    // Cancel the internet connection stream subscription
    internetConnectionStreamSubscription?.cancel();
    // Dispose the internet connection checker
    _internetConnectionChecker.dispose();
  }
}
