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
    apiKey: 'AIzaSyBEBCnTmL6JlvWEo_NAT8_kPM2y3S6d-G8',
    appId: '1:727212500299:web:ce7129357f9a26ea7934ce',
    messagingSenderId: '727212500299',
    projectId: 'stackbuld-554db',
    authDomain: 'stackbuld-554db.firebaseapp.com',
    storageBucket: 'stackbuld-554db.appspot.com',
    measurementId: 'G-2M1NMLRCYC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqG33W6Vi1rfS42IJehzcqt6njCtXVYkY',
    appId: '1:727212500299:android:58a20166f7f4a6477934ce',
    messagingSenderId: '727212500299',
    projectId: 'stackbuld-554db',
    storageBucket: 'stackbuld-554db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAHXlXlXVNVmY2-i_MwabJ3rOqalnmKOZo',
    appId: '1:727212500299:ios:2ee0fbf56f05f9f47934ce',
    messagingSenderId: '727212500299',
    projectId: 'stackbuld-554db',
    storageBucket: 'stackbuld-554db.appspot.com',
    iosBundleId: 'com.example.stackbuld',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAHXlXlXVNVmY2-i_MwabJ3rOqalnmKOZo',
    appId: '1:727212500299:ios:2ee0fbf56f05f9f47934ce',
    messagingSenderId: '727212500299',
    projectId: 'stackbuld-554db',
    storageBucket: 'stackbuld-554db.appspot.com',
    iosBundleId: 'com.example.stackbuld',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBEBCnTmL6JlvWEo_NAT8_kPM2y3S6d-G8',
    appId: '1:727212500299:web:39e195c580c6867d7934ce',
    messagingSenderId: '727212500299',
    projectId: 'stackbuld-554db',
    authDomain: 'stackbuld-554db.firebaseapp.com',
    storageBucket: 'stackbuld-554db.appspot.com',
    measurementId: 'G-G3WSH3QXTZ',
  );
}
