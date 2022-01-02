import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:online_shop_user/view/splash/splash.dart';

import 'global/global.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  //FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //EcommerceApp.auth = FirebaseAuth.instance;
  runApp(const MyApp());
}
//global olarak her yerden ulaşmak istediğimiz kodları açıklama
//satırı olarak belirttiğimiz yere yazıyoruz.

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      //home: AddUser("John Doe", "Stokes and Sons", 42),
      home: const Splash(),
    );
  }
}

///flutter build apk
///flutter build apk --debug
///flutter build apk --release
///https://flutteragency.com/make-release-apk-from-android-studio/
