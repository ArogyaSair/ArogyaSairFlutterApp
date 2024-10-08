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
    apiKey: 'AIzaSyBZV74izNyko-K9LRjwD2hawI35mxnuJb8',
    appId: '1:230126129231:web:6e1339a0a91fb794fe9a3a',
    messagingSenderId: '230126129231',
    projectId: 'arogyasair-157e8',
    authDomain: 'arogyasair-157e8.firebaseapp.com',
    databaseURL: 'https://arogyasair-157e8-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'arogyasair-157e8.appspot.com',
    measurementId: 'G-Y7ED5GHPXX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAF8P2z1zD0M7LNoBPi9JSUBxkC3Td0sBY',
    appId: '1:230126129231:android:f68429f8b7603540fe9a3a',
    messagingSenderId: '230126129231',
    projectId: 'arogyasair-157e8',
    databaseURL: 'https://arogyasair-157e8-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'arogyasair-157e8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDzhq5pOmFFGGqFt0be_0Oxhlz2tbkhh3k',
    appId: '1:230126129231:ios:a5c3b8fb08971154fe9a3a',
    messagingSenderId: '230126129231',
    projectId: 'arogyasair-157e8',
    databaseURL: 'https://arogyasair-157e8-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'arogyasair-157e8.appspot.com',
    iosBundleId: 'com.example.arogyasair',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDzhq5pOmFFGGqFt0be_0Oxhlz2tbkhh3k',
    appId: '1:230126129231:ios:a5c3b8fb08971154fe9a3a',
    messagingSenderId: '230126129231',
    projectId: 'arogyasair-157e8',
    databaseURL:
        'https://arogyasair-157e8-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'arogyasair-157e8.appspot.com',
    iosBundleId: 'com.example.arogyasair',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBZV74izNyko-K9LRjwD2hawI35mxnuJb8',
    appId: '1:230126129231:web:afe8b41d8a3155d6fe9a3a',
    messagingSenderId: '230126129231',
    projectId: 'arogyasair-157e8',
    authDomain: 'arogyasair-157e8.firebaseapp.com',
    databaseURL: 'https://arogyasair-157e8-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'arogyasair-157e8.appspot.com',
    measurementId: 'G-FMBWHKDEJL',
  );
}
