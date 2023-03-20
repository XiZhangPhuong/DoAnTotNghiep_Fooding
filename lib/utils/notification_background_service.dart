// import 'dart:ui';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:template/utils/firebase_service.dart';
// import 'package:template/utils/local_notification_service.dart';

// class NotificationBackgroundService {
//   // final FlutterBackgroundService service = FlutterBackgroundService();
//   final localNotification = LocalNotificationService();
//   NotificationBackgroundService() {
//     _initBackground();
//   }
//   Future<void> _initBackground() async {
//     await Firebase.initializeApp();
//     await localNotification.init();
//     await FcmService().init();
//     await FcmService().initForegroundNotification();
//     // localNotification.registerChannelAndroid();
//     // await localNotification.init();
//     FcmService().backgroundHandler();

//     // await service.configure(
//     //   iosConfiguration: IosConfiguration(
//     //     onBackground: _onBackground,
//     //     onForeground: (server) {},
//     //   ),
//     //   androidConfiguration: AndroidConfiguration(
//     //     onStart: _onStart,
//     //     isForegroundMode: true,
//     //     notificationChannelId: notificationChannelId, // this must match with notification channel you created above.
//     //     // initialNotificationTitle: 'ABC',
//     //     // initialNotificationContent: 'ABC',
//     //     foregroundServiceNotificationId: 2,
//     //   ),
//     // );
//   }

//   /// IOS.
//   static Future<bool> _onBackground(ServiceInstance val) async {
//     DartPluginRegistrant.ensureInitialized();
//     return true;
//   }

//   /// Android.
//   @pragma('vm:entry-point')
//   static Future<void> _onStart(ServiceInstance service) async {
//     DartPluginRegistrant.ensureInitialized();
//     if (service is AndroidServiceInstance) {
//       service.on('setAsForeground').listen((event) {
//         service.setAsForegroundService();
//       });

//       service.on('setAsBackground').listen((event) {
//         service.setAsBackgroundService();
//       });
//     }

//     service.on('stopService').listen((event) {
//       service.stopSelf();
//     });
//   }
// }
