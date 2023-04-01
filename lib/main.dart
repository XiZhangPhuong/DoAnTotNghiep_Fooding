import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooding_project/routes/app_routes.dart';
import 'package:fooding_project/routes/routes_path/auth_routes.dart';
import 'package:fooding_project/routes/routes_path/home_routes.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'app_binding.dart';
import 'di_container.dart' as di;
import 'firebase_options.dart';
import 'helper/izi_timezone.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  // Set timezone
  IZITimeZone().initializeTimeZones();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      initialRoute: AuthRoutes.DASHBOARD,
      // theme: ThemeData(
      //   primaryColor: ColorResources.RED2
      // ),
      getPages: AppPages.list,
      initialBinding: AppBinding(),
    );
  }
}
