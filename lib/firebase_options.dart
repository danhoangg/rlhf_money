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
    apiKey: 'AIzaSyAjra-GRsleP0zasZ6-_88eei8RngoOVgU',
    appId: '1:138858862807:web:bb640d761903e066b43892',
    messagingSenderId: '138858862807',
    projectId: 'rlhf-money-69636',
    authDomain: 'rlhf-money-69636.firebaseapp.com',
    storageBucket: 'rlhf-money-69636.appspot.com',
    measurementId: 'G-P12P7471YF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbFh4o_Mjz2438FHf-nvcCcWiEbZHipc8',
    appId: '1:138858862807:android:2a90c88140707230b43892',
    messagingSenderId: '138858862807',
    projectId: 'rlhf-money-69636',
    storageBucket: 'rlhf-money-69636.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmX8ghdcPsup8mdqeFScH6puibitxW5nc',
    appId: '1:138858862807:ios:9084cd1e9acf9097b43892',
    messagingSenderId: '138858862807',
    projectId: 'rlhf-money-69636',
    storageBucket: 'rlhf-money-69636.appspot.com',
    iosBundleId: 'com.example.rlhfMoney',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAmX8ghdcPsup8mdqeFScH6puibitxW5nc',
    appId: '1:138858862807:ios:18b0ba100a64e72ab43892',
    messagingSenderId: '138858862807',
    projectId: 'rlhf-money-69636',
    storageBucket: 'rlhf-money-69636.appspot.com',
    iosBundleId: 'com.example.rlhfMoney.RunnerTests',
  );
}
