import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labor_management_system/core/utils/global_utils/global_utils.dart';
import 'package:labor_management_system/lms_app.dart';

import 'core/injectors/injector.dart' show initDependencies;
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await _initLocalAndThirdPartyDependencies();

  // Initialize the injector dependencies
  await initDependencies();

  setupDebugLogs();

  runApp(const LmsApp());
}

///
/// Method to initialize the third party dependencies
///
Future<void> _initLocalAndThirdPartyDependencies() async {
  // Making the app should stay in portrait mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Future.wait([

    // Initializing firebase app
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    // Waiting for the window size to be initialized
    ScreenUtil.ensureScreenSize(),
  ]);
}

