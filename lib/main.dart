import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooding_project/routes/app_routes.dart';
import 'package:fooding_project/routes/routes_path/auth_routes.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get_navigation/get_navigation.dart';
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AuthRoutes.SPLASH,
      getPages: AppPages.list,
      locale: const Locale('vi', 'VN'),
      localizationsDelegates: localizationsDelegates,
      initialBinding: AppBinding(),
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
