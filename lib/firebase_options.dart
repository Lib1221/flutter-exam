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
    apiKey: 'AIzaSyB42pYwgTe8hSjttWAMkYghWDjnd_OevAY',
    appId: '1:242675705969:web:136077d6b891949f0f13d0',
    messagingSenderId: '242675705969',
    projectId: 'exam-37b46',
    authDomain: 'exam-37b46.firebaseapp.com',
    storageBucket: 'exam-37b46.firebasestorage.app',
    measurementId: 'G-95LZ59T7M9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXm7IVMBzLQJAR4e3hWuQ8vRZLqw-Kx6M',
    appId: '1:242675705969:android:d3657d7fb061e8b80f13d0',
    messagingSenderId: '242675705969',
    projectId: 'exam-37b46',
    storageBucket: 'exam-37b46.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4m51cQ2LhVErRbKbxR09ObbOqw0eD4as',
    appId: '1:242675705969:ios:89bfc48a29e6ccf50f13d0',
    messagingSenderId: '242675705969',
    projectId: 'exam-37b46',
    storageBucket: 'exam-37b46.firebasestorage.app',
    iosBundleId: 'com.example.examStore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC4m51cQ2LhVErRbKbxR09ObbOqw0eD4as',
    appId: '1:242675705969:ios:89bfc48a29e6ccf50f13d0',
    messagingSenderId: '242675705969',
    projectId: 'exam-37b46',
    storageBucket: 'exam-37b46.firebasestorage.app',
    iosBundleId: 'com.example.examStore',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB42pYwgTe8hSjttWAMkYghWDjnd_OevAY',
    appId: '1:242675705969:web:26d7df987e13d9c30f13d0',
    messagingSenderId: '242675705969',
    projectId: 'exam-37b46',
    authDomain: 'exam-37b46.firebaseapp.com',
    storageBucket: 'exam-37b46.firebasestorage.app',
    measurementId: 'G-TGMZ5N42NW',
  );
}
