import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Top-level background message handler required by Firebase Messaging
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
  } catch (_) {}
  debugPrint('[FCM Background] Handling notification: ${message.messageId}');
  debugPrint('[FCM Background] Title: ${message.notification?.title}');
  debugPrint('[FCM Background] Data payload: ${message.data}');
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  FirebaseMessaging? get _fcm {
    try {
      return FirebaseMessaging.instance;
    } catch (_) {
      return null;
    }
  }

  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  static const String channelIdWWCD = 'scrim_pulse_wwcd_channel';
  static const String channelNameWWCD = 'Chicken Dinner Alerts';
  static const String channelDescWWCD = 'Instant alerts when a team clutches WWCD';

  static const String channelIdMatch = 'scrim_pulse_match_channel';
  static const String channelNameMatch = 'Match Schedule & Start';
  static const String channelDescMatch = 'Live match countdowns and map start alerts';

  Future<void> initialize({Function(String? payload)? onNotificationClick}) async {
    // 1. Request Notification Permissions if FCM is available
    final fcm = _fcm;
    if (fcm != null) {
      try {
        final settings = await fcm.requestPermission(
          alert: true,
          badge: true,
          sound: true,
          provisional: false,
          criticalAlert: true,
        );
        debugPrint('[FCM] Permission status: ${settings.authorizationStatus}');
      } catch (e) {
        debugPrint('[FCM] Permission request error: $e');
      }
    }

    // 2. Setup Android Notification Channel
    const androidInitSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          debugPrint('[Notification Click] Payload: ${response.payload}');
          onNotificationClick?.call(response.payload);
        }
      },
    );

    // 3. Register High-Priority Android Notification Channels
    final androidPlugin = _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          channelIdWWCD,
          channelNameWWCD,
          description: channelDescWWCD,
          importance: Importance.max,
          playSound: true,
          enableVibration: true,
        ),
      );

      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          channelIdMatch,
          channelNameMatch,
          description: channelDescMatch,
          importance: Importance.high,
          playSound: true,
        ),
      );
    }

    // 4. Foreground FCM Listener
    if (fcm != null) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('[FCM Foreground] Received: ${message.notification?.title}');
        showNotificationFromRemote(message);
      });

      // 5. App Opened via Notification from Background/Terminated
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint('[FCM OpenedApp] User clicked notification: ${message.data}');
        onNotificationClick?.call(jsonEncode(message.data));
      });

      // 6. Subscribe to Global BGMI Tournament Topics
      await subscribeToTopic('all_tournaments');
      await subscribeToTopic('live_matches');
    }
  }

  /// Display heads-up banner notification when app is in foreground
  Future<void> showNotificationFromRemote(RemoteMessage message) async {
    final notification = message.notification;
    final data = message.data;

    final isWWCD = data['type'] == 'WWCD' || (notification?.title?.contains('WWCD') ?? false);
    final channelId = isWWCD ? channelIdWWCD : channelIdMatch;
    final channelName = isWWCD ? channelNameWWCD : channelNameMatch;

    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      color: const Color(0xFFDFFF00),
      styleInformation: BigTextStyleInformation(
        notification?.body ?? '',
        contentTitle: notification?.title,
      ),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      message.hashCode,
      notification?.title ?? 'ScrimPulse Alert',
      notification?.body ?? 'Live tournament update available',
      details,
      payload: jsonEncode(data),
    );
  }

  /// Trigger local simulated match start or WWCD alert (for offline testing & UI preview)
  Future<void> showInstantAlert({
    required String title,
    required String body,
    bool isWWCD = false,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      isWWCD ? channelIdWWCD : channelIdMatch,
      isWWCD ? channelNameWWCD : channelNameMatch,
      importance: Importance.max,
      priority: Priority.high,
      color: isWWCD ? const Color(0xFFFFD700) : const Color(0xFF00F5D4),
    );

    await _localNotifications.show(
      DateTime.now().millisecond,
      title,
      body,
      NotificationDetails(android: androidDetails),
    );
  }

  Future<void> subscribeToTopic(String topic) async {
    try {
      final fcm = _fcm;
      if (fcm != null) {
        await fcm.subscribeToTopic(topic);
        debugPrint('[FCM] Subscribed to topic: $topic');
      }
    } catch (e) {
      debugPrint('[FCM] Error subscribing to $topic: $e');
    }
  }

  Future<String?> getDeviceToken() async {
    try {
      final fcm = _fcm;
      if (fcm != null) {
        final token = await fcm.getToken();
        debugPrint('[FCM Token]: $token');
        return token;
      }
      return null;
    } catch (e) {
      debugPrint('[FCM] Failed to get token: $e');
      return null;
    }
  }
}

