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
    apiKey: 'AIzaSyColD_pAhyn0ExyDfWOIFboj1xEKrh62O4',
    appId: '1:792212394215:web:ed0d9633329c7215f71242',
    messagingSenderId: '792212394215',
    projectId: 'project-hmc-10dd7',
    authDomain: 'project-hmc-10dd7.firebaseapp.com',
    databaseURL: 'https://project-hmc-10dd7-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'project-hmc-10dd7.appspot.com',
    measurementId: 'G-DKVP61DQMG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA74xGk9QDtKfhqZDwJS2BhoDMpmwHsX6k',
    appId: '1:792212394215:android:f5ac1432f99e7769f71242',
    messagingSenderId: '792212394215',
    projectId: 'project-hmc-10dd7',
    databaseURL: 'https://project-hmc-10dd7-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'project-hmc-10dd7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUV9-rYneLLa81Z5G8_yjLX7JThPeEVLE',
    appId: '1:792212394215:ios:ebe5c951e5ddb4e2f71242',
    messagingSenderId: '792212394215',
    projectId: 'project-hmc-10dd7',
    databaseURL: 'https://project-hmc-10dd7-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'project-hmc-10dd7.appspot.com',
    iosClientId: '792212394215-bfeod4v4ga6e3nlpq5gh8620379h70pd.apps.googleusercontent.com',
    iosBundleId: 'com.example.projectHmc',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBUV9-rYneLLa81Z5G8_yjLX7JThPeEVLE',
    appId: '1:792212394215:ios:ebe5c951e5ddb4e2f71242',
    messagingSenderId: '792212394215',
    projectId: 'project-hmc-10dd7',
    databaseURL: 'https://project-hmc-10dd7-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'project-hmc-10dd7.appspot.com',
    iosClientId: '792212394215-bfeod4v4ga6e3nlpq5gh8620379h70pd.apps.googleusercontent.com',
    iosBundleId: 'com.example.projectHmc',
  );
}