import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
        case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }


  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBowPwIo3rKO7OgYW2Rih8JuRhtVhJgUug',
    appId: '1:378200727300:web:abdf5f7ca6739694d93a51',
    messagingSenderId: '378200727300',
    projectId: 'kangleitaxi',
    authDomain: 'kangleitaxi.firebaseapp.com',
    storageBucket: 'kangleitaxi.appspot.com',
    measurementId: 'G-W2VHP1TMPE',
    databaseURL: "https://kangleitaxi.firebaseio.com",



  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJoQwu0-7IDwW3H5RyLuJJjfAyUUNq_hg',
    appId: '1:378200727300:android:0036401fffb41b88d93a51',
    messagingSenderId: '378200727300',
    projectId: 'kangleitaxi',
    storageBucket: 'kangleitaxi.appspot.com',
    authDomain: "kangleitaxi.firebaseapp.com",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJoQwu0-7IDwW3H5RyLuJJjfAyUUNq_hg',
    appId: '1:378200727300:ios:42ce9d238ce6318dd93a51',
    messagingSenderId: '378200727300',
    projectId: 'kangleitaxi',
    storageBucket: 'kangleitaxi.appspot.com',
    androidClientId: '378200727300-7ie7cqpqllqj9k6it22kcse4j4f5nonk.apps.googleusercontent.com',
    iosClientId: '378200727300-7ie7cqpqllqj9k6it22kcse4j4f5nonk.apps.googleusercontent.com',
    iosBundleId: 'com.kangleiinnovations.kangleitaxi',
  );
}