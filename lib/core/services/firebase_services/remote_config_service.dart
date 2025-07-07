import 'package:firebase_remote_config/firebase_remote_config.dart'
    show FirebaseRemoteConfig, RemoteConfigSettings;
import 'package:labor_management_system/core/extensions/logs/log_ext.dart';

///
/// Firebase Remote Config Service for fetching the remote config values
///
class RemoteConfigService {
  /* -------------------------------------------------------------------------- */
  /*                                  VARIABLES                                 */
  /* -------------------------------------------------------------------------- */

  ///
  /// Remote Config singleton instance
  ///
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  /* -------------------------------------------------------------------------- */
  /*                                   METHODS                                  */
  /* -------------------------------------------------------------------------- */

  ///
  /// Initializes the remote config service with the default settings
  /// and fetches the remote config values
  ///
  Future<void> initialized() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration()),
    );
    //fetch data from remote config
    await fetchAndActivateData();
  }

  ///
  /// Fetches the remote configuration values and activate them
  ///

  Future<void> fetchAndActivateData() async {
    try {
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      'Error while fetching remote config data: $e'.logs();
    }
  }

  String getStringRemoteConfig(String key) {
    return  _remoteConfig.getString(key);
  }

  String get getThemeConfiguration => _remoteConfig.getString("themes").isEmpty
      ? ""
      : _remoteConfig.getString("themes");
}
