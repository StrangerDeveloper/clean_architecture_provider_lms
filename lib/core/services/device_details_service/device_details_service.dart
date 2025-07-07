import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show MethodChannel;

import '../../constants/app_keys/app_keys.dart';
import 'package:labor_management_system/core/extensions/logs/log_ext.dart';

/// A service class that provides device details such as model, unique ID, and channel.
///
/// This class uses `DeviceInfoPlugin` to fetch device information and `MethodChannel`
/// to communicate with the native platform for fetching the device ID.
///
/// The `DeviceDetailsService` class requires the following dependencies:
/// - `DeviceInfoPlugin` for retrieving device information.
/// - `MethodChannel` for invoking platform-specific methods.
/// - `AppKeys` for accessing application-specific keys.
///
/// The class provides methods to:
/// - Fetch and set the device ID.
/// - Retrieve device details such as model, unique ID, and channel.
///
/// Example usage:
/// ```dart
/// final deviceDetailsService = DeviceDetailsService(
///   deviceInfo: DeviceInfoPlugin(),
///   methodChannel: MethodChannel('your_channel_name'),
///   appKeys: AppKeys(),
/// );
/// await deviceDetailsService.getDeviceDetails();
/// print(deviceDetailsService.deviceModel);
/// print(deviceDetailsService.deviceUniqueId);
/// print(deviceDetailsService.channel);
/// ```
class DeviceDetailsService {
  /// An instance of `DeviceInfoPlugin` used to retrieve device information.
  final DeviceInfoPlugin deviceInfo;

  /// A `MethodChannel` for invoking platform-specific methods.
  final MethodChannel methodChannel;

  /// An instance of `AppKeys` for accessing application-specific keys.
  final AppKeys appKeys;

  /// The model of the device.
  String? deviceModel;

  /// The unique ID of the device.
  String? deviceUniqueId;

  /// The channel of the device (e.g., web, Android, iOS).
  String? channel;

  /// Constructor that takes dependencies as parameters.
  DeviceDetailsService({
    required this.deviceInfo,
    required this.methodChannel,
    required this.appKeys,
  });

  ///
  /// This function will be used to get device details of the user's device
  ///
  Future<void> getDeviceDetails() async {
    await fetchDeviceId();
    if (kIsWeb) {
      channel = 'web';
    } else {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceModel = androidInfo.model;
        deviceUniqueId = getTheDeviceId();
        channel = appKeys.deviceChannelAndroid;
        'DEVICE MODEL IS $deviceModel'.logs();
        'DEVICE uniqueID IS $deviceUniqueId'.logs();
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceModel = iosInfo.utsname.machine;
        channel = appKeys.deviceChannelIOS;
        'DEVICE MODEL IS $deviceModel'.logs();
      }
    }
  }

  /// This function returns the local device ID of the user's device.
  String? getTheDeviceId() {
    return deviceUniqueId;
  }

  /// This function sets the local device ID.
  void setDeviceId(String deviceId) {
    deviceUniqueId = deviceId;
  }

  /// This method fetches the device ID of the current device using the MethodChannel.
  Future<void> fetchDeviceId() async {
    try {
      final deviceId = await methodChannel.invokeMethod(
        appKeys.deviceIdIdentifier,
      );
      setDeviceId(deviceId);
    } catch (e) {
      "Failed to fetch device ID: $e".logs();
    }
  }
}
