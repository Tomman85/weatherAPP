
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
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
apiKey: 'AIzaSyDd1_8ssSIp_1WkJfEHT9ymDk-UPDh6QnI',
appId: '1:642195328641:android:0fe6f50e981fc152380780',
messagingSenderId: '642195328641',
projectId: 'weatherapp-dbb5d',
storageBucket: 'weatherapp-dbb5d.appspot.com',
);

static const FirebaseOptions ios = FirebaseOptions(
apiKey: 'AIzaSyA9it44Ja85-HJF82qURcSCU9nOy8PMq9k',
appId: '1:642195328641:ios:e7a72b2ddfe71181380780',
messagingSenderId: '642195328641',
projectId: 'weatherapp-dbb5d',
storageBucket: 'weatherapp-dbb5d.appspot.com',
iosClientId: '642195328641-b0f289etfqvnqbfii6tfco3224oll7ue.apps.googleusercontent.com',
iosBundleId: 'com.example.weather',
);
}