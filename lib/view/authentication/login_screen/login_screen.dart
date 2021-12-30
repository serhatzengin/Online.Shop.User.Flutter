import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_user/component/custom_button.dart';
import 'package:online_shop_user/component/custom_text_field.dart';
import 'package:online_shop_user/component/error_dialog.dart';
import 'package:online_shop_user/component/loading_dialog.dart';
import 'package:online_shop_user/global/globaal.dart';
import 'package:online_shop_user/view/authentication/auth_screen/auth_screen.dart';
import 'package:online_shop_user/view/home/homepage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  formValidation() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      loginNow();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ErrorDialog(
            message: "E Posta ve Şifre Boş Bırakılamaz!",
          );
        },
      );
    }
  }

  loginNow() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LoadingDialog(
          message: "Giriş Yapılıyor, Lütfen Bekeleyiniz!",
        );
      },
    );
    User? currentUser;
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((auth) => currentUser = auth.user)
        .catchError((error) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(message: error.toString());
        },
      );
    });

    if (currentUser != null) {
      readAndSetDataLocally(currentUser!);
    }
  }

  Future readAndSetDataLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        await sharedPreferences!.setString("uid", currentUser.uid);
        await sharedPreferences!.setString("email", snapshot.data()!["email"]);
        await sharedPreferences!.setString("name", snapshot.data()!["name"]);
        await sharedPreferences!
            .setString("photoUrl", snapshot.data()!["photoUrl"]);
        Navigator.pop(context);
        Route newRoute = MaterialPageRoute(builder: (c) => const HomePage());
        Navigator.pushReplacement(context, newRoute);
      } else {
        firebaseAuth.signOut();
        Route newRoute = MaterialPageRoute(builder: (c) => AuthPage());
        Navigator.pushReplacement(context, newRoute);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ErrorDialog(message: "No Record Exist!");
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: emailController,
                  icondata: Icons.email,
                  hintText: "E Postanızı Giriniz",
                  isObsecre: false,
                  enabled: true,
                ),
                CustomTextField(
                  controller: passwordController,
                  icondata: Icons.lock,
                  hintText: "Şifrenizi Giriniz",
                  isObsecre: true,
                  enabled: true,
                ),
                CustomButton(
                  pressed: () {
                    formValidation();
                  },
                  buttonText: "Giriş Yap",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
