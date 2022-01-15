import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_shop_user/component/custom_text_field.dart';

import 'package:online_shop_user/component/my_app_bar.dart';
import 'package:online_shop_user/global/global.dart';
import 'package:online_shop_user/model/address.dart';
import 'package:online_shop_user/view/home/homepage.dart';

class AddAdress extends StatelessWidget {
  AddAdress({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController cName = TextEditingController();
  TextEditingController cPhoneNumber = TextEditingController();
  TextEditingController cFlatHomeNumber = TextEditingController();
  TextEditingController cCity = TextEditingController();
  TextEditingController cState = TextEditingController();
  TextEditingController cPostaCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(show: false, name: "Yeni Adres Ekle"),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            final model = AddressModel(
              name: cName.text.trim(),
              phoneNumber: cPhoneNumber.text,
              cFlatHomeNumber: cFlatHomeNumber.text.trim(),
              city: cCity.text.trim(),
              state: cState.text.trim(),
              postaCode: cPostaCode.text.trim(),
            ).toJson();

            FirebaseFirestore.instance
                .collection("users")
                .doc(sharedPreferences!.getString("uid"))
                .collection("userAddress")
                .doc(DateTime.now().millisecondsSinceEpoch.toString())
                .set(model)
                .then((value) {
              Fluttertoast.showToast(msg: "Adres Başarılı Şekilde Eklendi");
              FocusScope.of(context).requestFocus(FocusNode());
              formKey.currentState!.reset();
            });
          }

          Route route = MaterialPageRoute(builder: (c) => const HomePage());
          Navigator.pushReplacement(context, route);
        },
        label: const Text("Tamam"),
        icon: const Icon(Icons.check),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text("Yeni Adres Ekle"),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: cName,
                    hintText: "İsim",
                    enabled: true,
                    isObsecre: false,
                  ),
                  CustomTextField(
                    controller: cPhoneNumber,
                    hintText: "Telefon Numarası",
                    enabled: true,
                    isObsecre: false,
                  ),
                  CustomTextField(
                    controller: cFlatHomeNumber,
                    hintText: "Daire Numarası / Ev Numarası",
                    enabled: true,
                    isObsecre: false,
                  ),
                  CustomTextField(
                    controller: cCity,
                    hintText: "Şehir",
                    enabled: true,
                    isObsecre: false,
                  ),
                  CustomTextField(
                    controller: cState,
                    hintText: "Ülke",
                    enabled: true,
                    isObsecre: false,
                  ),
                  CustomTextField(
                    controller: cPostaCode,
                    hintText: "Posta Kodu",
                    enabled: true,
                    isObsecre: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class MyTextField extends StatelessWidget {
//   final String? hintText;
//   final TextEditingController? controller;

//   const MyTextField({
//     Key? key,
//     this.hintText,
//     this.controller,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//         controller: controller,
//         validator: (value) => value!.isEmpty ? "Alan Boş Bırakılamaz" : null);
//   }
// }
