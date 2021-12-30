import 'package:flutter/material.dart';
import 'package:online_shop_user/view/authentication/login_screen/login_screen.dart';
import 'package:online_shop_user/view/authentication/register_screen/register_screen.dart';
import '../login_screen/loginscreen_temporary.dart';

class AuthPage extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Giriş Yap'),
    const Tab(text: 'Giriş Yap Referans'),
    const Tab(text: 'Kayıt Ol'),
  ];

  AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: myTabs,
          ),
        ),
        body: const TabBarView(children: [
          LoginScreen(),
          LoginScreenTemporary(),
          RegisterScreen(),
        ]),
      ),
    );
  }
}
