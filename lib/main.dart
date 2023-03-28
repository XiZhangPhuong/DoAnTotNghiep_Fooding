
import 'package:flutter/material.dart';
import 'package:fooding_project/routes/app_routes.dart';
import 'package:fooding_project/routes/routes_path/dash_board_routes.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: DashBoardRoutes.DASHBOARD,
      getPages: AppPages.list,
    );
  }
}
