import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:labor_management_system/core/extensions/logs/log_ext.dart';

class FCMService {
  FCMService({required this.firebaseMessaging});

  /* -------------------------------------------- */
  /*                   VARIABLES                  */
  /* -------------------------------------------- */

  final FirebaseMessaging firebaseMessaging;

  /* -------------------------------------------- */
  /*                    METHODS                   */
  /* -------------------------------------------- */

  /// Get FCM token of current device
  Future<String> getFCMToken() async {
    final settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      return (await firebaseMessaging.getToken()) ?? '';
    } else {
      return '';
    }
  }

  /// Request permission for FCM
  Future<void> requestPermission() async {
    firebaseMessaging
        .requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        )
        .then((NotificationSettings notificationSettings) {
          if (notificationSettings.authorizationStatus ==
              AuthorizationStatus.authorized) {
            'User granted permission'.logs();
          } else if (notificationSettings.authorizationStatus ==
              AuthorizationStatus.provisional) {
            'User granted provisional permission'.logs();
          } else {
            'User declined or has not accepted permission'.logs();
          }
        }, onError: (e) => e.log());
  }
}
