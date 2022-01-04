import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_user/component/custom_button.dart';
import 'package:online_shop_user/component/custom_text_field.dart';
import 'package:online_shop_user/component/error_dialog.dart';
import 'package:online_shop_user/view/home/admin/upload_items.dart';
import 'package:online_shop_user/view/home/homepage.dart';

class AdminSignInPage extends StatefulWidget {
  const AdminSignInPage({Key? key}) : super(key: key);

  @override
  _AdminSignInPageState createState() => _AdminSignInPageState();
}

class _AdminSignInPageState extends State<AdminSignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController adminIdController = TextEditingController();

  formValidation() {
    adminIdController.text.isNotEmpty && passwordController.text.isNotEmpty
        ? loginAdminNow()
        : showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ErrorDialog(
                message: "E Posta ve Şifre Boş Bırakılamaz!",
              );
            },
          );
  }

  loginAdminNow() {
    FirebaseFirestore.instance.collection("admins").get().then(
      (snapshot) {
        for (var result in snapshot.docs) {
          if (result.data()["id"] != adminIdController.text.trim()) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const ErrorDialog(message: "ID Yanlış");
              },
            );
          } else if (result.data()["password"] !=
              passwordController.text.trim()) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const ErrorDialog(message: "Şifren Yanlış");
              },
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Welcome Dear Admin, " + result.data()["name"])));

            setState(() {
              adminIdController.text = "";
              passwordController.text = "";
            });

            Route route = MaterialPageRoute(builder: (c) => const UploadPage());
            Navigator.pushReplacement(context, route);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: adminIdController,
                icondata: Icons.email,
                hintText: "Admin E Postanızı Giriniz",
                isObsecre: false,
                enabled: true,
              ),
              CustomTextField(
                controller: passwordController,
                icondata: Icons.lock,
                hintText: "Admin Şifrenizi Giriniz",
                isObsecre: true,
                enabled: true,
              ),
              CustomButton(
                pressed: () {
                  loginAdminNow();
                },
                buttonText: "Admin Giriş Yap",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
