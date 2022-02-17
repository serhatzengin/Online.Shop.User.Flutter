import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_user/global/global.dart';
import 'package:online_shop_user/view/authentication/auth_screen/auth_screen.dart';
import 'package:online_shop_user/view/home/homepage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    //todo super.initState nedir
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(
      const Duration(milliseconds: 250),
      () async {
        if (firebaseAuth.currentUser != null) {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(firebaseAuth.currentUser!.uid)
              .get()
              .then((snapshot) async {
            if (snapshot.exists) {
              await sharedPreferences!
                  .setString("uid", firebaseAuth.currentUser!.uid);
              await sharedPreferences!
                  .setString("email", snapshot.data()!["email"]);
              await sharedPreferences!
                  .setString("name", snapshot.data()!["name"]);
              await sharedPreferences!
                  .setString("photoUrl", snapshot.data()!["photoUrl"]);

              List<String> cartList =
                  snapshot.data()!["userCart"].cast<String>();

              await sharedPreferences!.setStringList("userCart", cartList);
              Route newRoute =
                  MaterialPageRoute(builder: (c) => const HomePage());
              Navigator.pushReplacement(context, newRoute);
            } else {
              firebaseAuth.signOut();
              Route newRoute = MaterialPageRoute(builder: (c) => AuthPage());
              Navigator.pushReplacement(context, newRoute);
            }
          });
        }
      },
    );
    // https://flutterdersleri.com/navigator-pushreplacement.html
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/splash/welcome.png',
              height: 200,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}
