import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyAapbbpqF-K0MFy32Rb8J0cDgamspPgKhU',
    appId: '1:576060610050:web:1a1cc8309b46128ef0b91b',
    messagingSenderId: '576060610050',
    projectId: 'simplejobs-55167',
    authDomain: 'simplejobs-55167.firebaseapp.com',
    databaseURL: 'https://simplejobs-55167-default-rtdb.firebaseio.com',
    storageBucket: 'simplejobs-55167.appspot.com',
    measurementId: 'G-NKKB7MZ4YK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCxaySZ1vvft4fhOW72laoW82NL9HIS1h4',
    appId: '1:576060610050:android:93ce40941d057bb0f0b91b',
    messagingSenderId: '576060610050',
    projectId: 'simplejobs-55167',
    databaseURL: 'https://simplejobs-55167-default-rtdb.firebaseio.com',
    storageBucket: 'simplejobs-55167.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCTLi2Rqjk8jJ7GeklRqW7HSqLL9CC9Bz0',
    appId: '1:576060610050:ios:28daf659ff91fff2f0b91b',
    messagingSenderId: '576060610050',
    projectId: 'simplejobs-55167',
    databaseURL: 'https://simplejobs-55167-default-rtdb.firebaseio.com',
    storageBucket: 'simplejobs-55167.appspot.com',
    iosClientId: '576060610050-4fentol9j5kl81h0dv6ecjc0shtaqqh4.apps.googleusercontent.com',
    iosBundleId: 'com.example.examen',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCTLi2Rqjk8jJ7GeklRqW7HSqLL9CC9Bz0',
    appId: '1:576060610050:ios:28daf659ff91fff2f0b91b',
    messagingSenderId: '576060610050',
    projectId: 'simplejobs-55167',
    databaseURL: 'https://simplejobs-55167-default-rtdb.firebaseio.com',
    storageBucket: 'simplejobs-55167.appspot.com',
    iosClientId: '576060610050-4fentol9j5kl81h0dv6ecjc0shtaqqh4.apps.googleusercontent.com',
    iosBundleId: 'com.example.examen',
  );
}
