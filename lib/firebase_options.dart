// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA8yG5u1sBlyZmI4hJmqiR81j5pb5F9Bz4',
    appId: '1:156540035401:web:f243528b418881adb13a98',
    messagingSenderId: '156540035401',
    projectId: 'fastfooddelivery-646b3',
    authDomain: 'fastfooddelivery-646b3.firebaseapp.com',
    databaseURL: 'https://fastfooddelivery-646b3-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fastfooddelivery-646b3.appspot.com',
    measurementId: 'G-WQY72443NV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAHueeKcKT6RkTtgbKLI7qm-nza7mwldz4',
    appId: '1:156540035401:android:64083a50019007cbb13a98',
    messagingSenderId: '156540035401',
    projectId: 'fastfooddelivery-646b3',
    databaseURL: 'https://fastfooddelivery-646b3-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fastfooddelivery-646b3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBGHD0kNCzOsMcATRo50ZdwyEbLsG1nUe0',
    appId: '1:156540035401:ios:5390b11ced86a427b13a98',
    messagingSenderId: '156540035401',
    projectId: 'fastfooddelivery-646b3',
    databaseURL: 'https://fastfooddelivery-646b3-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fastfooddelivery-646b3.appspot.com',
    androidClientId: '156540035401-cfn6pm1jueon3m1438csi39b6f2dntu9.apps.googleusercontent.com',
    iosClientId: '156540035401-vf64osft6st286hui46kcl8f85etk3q6.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodingProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBGHD0kNCzOsMcATRo50ZdwyEbLsG1nUe0',
    appId: '1:156540035401:ios:5390b11ced86a427b13a98',
    messagingSenderId: '156540035401',
    projectId: 'fastfooddelivery-646b3',
    databaseURL: 'https://fastfooddelivery-646b3-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fastfooddelivery-646b3.appspot.com',
    androidClientId: '156540035401-cfn6pm1jueon3m1438csi39b6f2dntu9.apps.googleusercontent.com',
    iosClientId: '156540035401-vf64osft6st286hui46kcl8f85etk3q6.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodingProject',
  );
}