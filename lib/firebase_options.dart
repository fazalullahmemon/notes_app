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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCP8MSsdUarFGz09eVtskSUZ2LW94oNuvo',
    appId: '1:9867133777:android:91ccb89e0bcce9f9d70970',
    messagingSenderId: '9867133777',
    projectId: 'notes-app-d83bd',
    storageBucket: 'notes-app-d83bd.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB3B7C00w0XrjRyvWUWSHKwLQ25nzL-EYs',
    appId: '1:9867133777:ios:2f063794fe4f6bebd70970',
    messagingSenderId: '9867133777',
    projectId: 'notes-app-d83bd',
    storageBucket: 'notes-app-d83bd.firebasestorage.app',
    androidClientId: '9867133777-a3b1b6m748ahtcmidchd5ovtni5vrnq6.apps.googleusercontent.com',
    iosClientId: '9867133777-pjs41c25p50jcor3dcpfcue6up6hg75v.apps.googleusercontent.com',
    iosBundleId: 'com.flutter.notesapp',
  );
}