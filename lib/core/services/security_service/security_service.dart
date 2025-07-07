import 'package:flutter/services.dart' show MethodChannel;
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:labor_management_system/core/extensions/logs/log_ext.dart';
import 'package:labor_management_system/core/utils/injector_utils/injector_helper.dart';

/// A service that provides security-related functionalities such as detecting
/// if the device is jail broken, rooted, or running on an emulator.

class SecurityService {
  /// Constructs a [SecurityService] instance.
  ///
  /// Takes a [JailbreakRootDetection] instance to check for jail broken or rooted devices
  /// and a [MethodChannel] for invoking platform-specific methods.

  SecurityService({
    required JailbreakRootDetection jailbreakRootDetection,
    required this.methodChannel,
  }) : _jailbreakRootDetection = jailbreakRootDetection;

  /* -------------------------------------------------------------------------- */
  /*                                  VARIABLES                                 */
  /* -------------------------------------------------------------------------- */

  /// An instance of `JailbreakRootDetection` to check if the device is jail broken or rooted.
  final JailbreakRootDetection _jailbreakRootDetection;

  /// A `MethodChannel` for invoking platform-specific methods.
  final MethodChannel methodChannel;

  /* -------------------------------------------------------------------------- */
  /*                                   METHODS                                  */
  /* -------------------------------------------------------------------------- */

  ///
  /// Check if the device is jail broken or rooted
  /// Returns true if the device is jail broken or rooted
  ///
  Future<bool> isJailBrokenAndRooted() async {
    // Check if the jail break or rooted device is enabled
    if (!injectedAppConstant.enableJailBreakOrRootedDeviceDetection) {
      return false;
    }

    try {
      return await _jailbreakRootDetection.isJailBroken;
    } catch (e) {
      e.logError();
    }

    return true;
  }

  /// Check if the device is running on an emulator
  Future<bool> isEmulator() async {
    // Check if the emulator detection is enabled
    if (!injectedAppConstant.enableEmulatorDetection) {
      return false;
    }

    try {
      return await methodChannel.invokeMethod(
        injectedAppKeys.isEmulatorIdentifier,
      );
    } catch (e) {
      "Error while checking if the device is running on an emulator: $e"
          .logError();
    }

    return true;
  }
}
