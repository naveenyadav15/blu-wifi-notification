import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_permissions/notification_permissions.dart';

class NotificationsManager {
  NotificationsManager._internal();

  static final NotificationsManager _shared = NotificationsManager._internal();

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  factory NotificationsManager() {
    return _shared;
  }

  bool isNotification = false;

  Future<FlutterLocalNotificationsPlugin> initializeNotifications() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('clock'); //ic_launcher
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    return _flutterLocalNotificationsPlugin;
  }

  Future<dynamic> onDidReceiveLocalNotification(
      id, title, body, payload) async {}

  FlutterLocalNotificationsPlugin getCurrentNotificationPlugin() {
    return _flutterLocalNotificationsPlugin;
  }

  void cancelNotificationWith(int id) {
    _flutterLocalNotificationsPlugin.cancel(id);
  }

  void cancelAllNotification() {
    if (isNotification) {
      isNotification = false;
      _flutterLocalNotificationsPlugin.cancelAll();
    }
  }

  void showNotifications(String body) {
    _showNotification(body);
  }

  void requestPermission() {
    NotificationPermissions.requestNotificationPermissions();
  }

  /// Checks the notification permission status
  Future<bool> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case PermissionStatus.denied:
          return false;
        case PermissionStatus.granted:
          return true;
        case PermissionStatus.unknown:
          return false;
        default:
          return null;
      }
    });
  }

  Future<void> _showNotification(String body) async {
    isNotification = true;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_id', 'channel_title', 'channel_description',
        importance: Importance.max, priority: Priority.high, ticker: body);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
        0, 'Snaptempo timer running', body, platformChannelSpecifics,
        payload: 'playload');
  }
}
