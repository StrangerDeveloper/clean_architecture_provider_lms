import 'dart:developer' show log;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../constants/app_keys/app_keys.dart';
import '../../injectors/injector.dart';

///
/// Global app navigator key for handing navigation state
///
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

///
/// Setup the logs for debug mode with [debugLogKey]
///
void setupDebugLogs() {
  debugPrint = (String? message, {int? wrapWidth}) {
    if (!kReleaseMode) {
      log(injector<AppKeys>().debugLogKey + message!);
    }
  };
}

///
/// Track the currently opened screen
///
String currentlyOpenedScreen = "";

///
/// Get the semantics value for the image
///

String getImageSemanticValue(String? imagePath) {
  return "${imagePath?.split('/').last.split('.').first} Image";
}
