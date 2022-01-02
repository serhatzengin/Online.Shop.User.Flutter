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
    await Future.delayed(const Duration(milliseconds: 1000), () {
      firebaseAuth.currentUser != null
          ? Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()))
          : Navigator.push(
              context, MaterialPageRoute(builder: (context) => AuthPage()));
    });
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
