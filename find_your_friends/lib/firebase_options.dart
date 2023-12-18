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
    apiKey: 'AIzaSyAXbiHksRg-Gg-HhTkMoTW5pwqgvEvsd-c',
    appId: '1:1095618288156:web:77b5657d4a8d3d14551dd9',
    messagingSenderId: '1095618288156',
    projectId: 'findyourfriends-408410',
    authDomain: 'findyourfriends-408410.firebaseapp.com',
    storageBucket: 'findyourfriends-408410.appspot.com',
    measurementId: 'G-JX6NV8NWG1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6aoe5esSR4qSfwtqSKbZlCjrZ6LMxCio',
    appId: '1:1095618288156:android:4c1412fa869ca919551dd9',
    messagingSenderId: '1095618288156',
    projectId: 'findyourfriends-408410',
    storageBucket: 'findyourfriends-408410.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBeZUb995-0QQilyDymQHvHnkVZqln39No',
    appId: '1:1095618288156:ios:0a6cfbf20da122ee551dd9',
    messagingSenderId: '1095618288156',
    projectId: 'findyourfriends-408410',
    storageBucket: 'findyourfriends-408410.appspot.com',
    iosBundleId: 'com.example.findYourFriends',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBeZUb995-0QQilyDymQHvHnkVZqln39No',
    appId: '1:1095618288156:ios:98756fd8daa27872551dd9',
    messagingSenderId: '1095618288156',
    projectId: 'findyourfriends-408410',
    storageBucket: 'findyourfriends-408410.appspot.com',
    iosBundleId: 'com.example.findYourFriends.RunnerTests',
  );
}
