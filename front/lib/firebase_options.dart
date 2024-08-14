// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCJbkCORtcOd1vuKRji2gK6bjbCFsI6mgk',
    appId: '1:198205233971:web:bfdb35f6614709be2dbc46',
    messagingSenderId: '198205233971',
    projectId: 'optiway-bf8ee',
    authDomain: 'optiway-bf8ee.firebaseapp.com',
    storageBucket: 'optiway-bf8ee.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUm9GrGCdYyXiQC0dI6FPO0d9OXcXpD00',
    appId: '1:198205233971:android:dbb2835c8f6f07272dbc46',
    messagingSenderId: '198205233971',
    projectId: 'optiway-bf8ee',
    storageBucket: 'optiway-bf8ee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUIRQejOwprlCtJBxCJII2Op6iLcs1Jb4',
    appId: '1:198205233971:ios:e64354e1670fec922dbc46',
    messagingSenderId: '198205233971',
    projectId: 'optiway-bf8ee',
    storageBucket: 'optiway-bf8ee.appspot.com',
    iosBundleId: 'com.example.front',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAUIRQejOwprlCtJBxCJII2Op6iLcs1Jb4',
    appId: '1:198205233971:ios:e64354e1670fec922dbc46',
    messagingSenderId: '198205233971',
    projectId: 'optiway-bf8ee',
    storageBucket: 'optiway-bf8ee.appspot.com',
    iosBundleId: 'com.example.front',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCJbkCORtcOd1vuKRji2gK6bjbCFsI6mgk',
    appId: '1:198205233971:web:f58115a17cce914a2dbc46',
    messagingSenderId: '198205233971',
    projectId: 'optiway-bf8ee',
    authDomain: 'optiway-bf8ee.firebaseapp.com',
    storageBucket: 'optiway-bf8ee.appspot.com',
  );
}
