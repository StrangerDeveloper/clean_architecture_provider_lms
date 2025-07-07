import 'package:flutter/material.dart';
import 'package:labor_management_system/core/extensions/logs/log_ext.dart';
import 'package:labor_management_system/features/splash/presentation/screens/splash_screen.dart';

import '../../core/shared/screens/error_screen.dart';
import '../../core/utils/global_utils/global_utils.dart';

///
/// AppRouter for handling routing in the app
///
class AppRouter {
  ///
  /// OnGenerateRoute method for handling routing
  ///
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    "GOING TO ROUTE: ${settings.name}".logs();

    //analytics should goes here if any

    // Setting currently opened screen
    currentlyOpenedScreen = settings.name ?? "";

    switch (settings.name) {
      case SplashScreen.id:
        return _buildMaterialPageRoute(
          route: const SplashScreen(),
          settings: settings,
        );


      default:
        return _buildMaterialPageRoute(
          route: const ErrorScreen(),
          settings: settings,
        );
    }
  }

  ///
  /// Build a MaterialPageRoute for the given route
  /// [route] - The widget to be displayed
  /// [settings] - The settings for the route
  ///
  MaterialPageRoute _buildMaterialPageRoute({
    required Widget route,
    required RouteSettings settings,
  }) {
    return MaterialPageRoute(builder: (_) => route, settings: settings);
  }
}
