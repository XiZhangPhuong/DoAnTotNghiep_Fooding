import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/routes/app_routes.dart';
import 'package:fooding_project/routes/routes_path/auth_routes.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:fooding_project/utils/firebase_service.dart';
import 'package:fooding_project/utils/local_notification_service.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'app_binding.dart';
import 'di_container.dart' as di;
import 'firebase_options.dart';
import 'helper/izi_dimensions.dart';
import 'helper/izi_timezone.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  // Set timezone
  IZITimeZone().initializeTimeZones();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  await LocalNotificationService().init();
  await FcmService().init();
  await FcmService().initForegroundNotification();
  FcmService().backgroundHandler();

  // Get device token.
  if (Platform.isAndroid) {
    final token = await messaging.getToken();
    sl<SharedPreferenceHelper>().setTokenDevice(token.toString());
  } else if (Platform.isIOS) {
    final token = await messaging.getAPNSToken();
    sl<SharedPreferenceHelper>().setTokenDevice(token.toString());
  }

  /// Instance Easy Loading.
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1500)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..progressColor = ColorResources.WHITE
    ..backgroundColor = ColorResources.PRIMARY_1
    ..indicatorColor = ColorResources.WHITE
    ..textColor = ColorResources.WHITE
    ..maskColor = Colors.transparent
    ..userInteractions = true
    ..textStyle = TextStyle(
      fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
      fontWeight: FontWeight.w700,
      color: ColorResources.WHITE,
    )
    ..dismissOnTap = false;

  // Set Device Orientation.
  setOrientation();
  if (Platform.isAndroid) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(const MyApp());
}

///
/// Set Device Orientation.
///
void setOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Đặt ứng dụng ở chế độ full màn hình
    // SystemChrome.setEnabledSystemUIOverlays([]);
    // SystemChrome.setSystemUIOverlayStyle(
    //    SystemUiOverlayStyle(
    //     statusBarColor: ColorResources.RED2, // Thiết lập màu sắc
    //     statusBarIconBrightness: Brightness.light, // Thiết lập màu icon
    //   ),
    // );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AuthRoutes.SPLASH,
      getPages: AppPages.list,
      locale: const Locale('vi', 'VN'),
      localizationsDelegates: localizationsDelegates,
      initialBinding: AppBinding(),
      theme: ThemeData(primaryColor: ColorResources.BACK_GROUND),
      builder: EasyLoading.init(
        builder: (context, widget) {
          return MediaQuery(
            //
            // Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0,
              boldText: false,
            ),
            child: widget!,
          );
        },
      ),
    );
  }
}
