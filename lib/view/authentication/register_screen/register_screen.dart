import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:online_shop_user/component/custom_button.dart';
import 'package:online_shop_user/component/custom_text_field.dart';
import 'package:online_shop_user/component/error_dialog.dart';
import 'package:online_shop_user/component/loading_dialog.dart';
import 'package:online_shop_user/global/global.dart';
import 'package:online_shop_user/view/home/homepage.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  XFile? imageXfile;
  final ImagePicker _picker = ImagePicker();

  String userImageUrl = "";

  Future<void> _getImage() async {
    try {
      imageXfile = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        imageXfile;
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  Future<void> validate() async {
    //todo validate fonksiyonu text field içerisine alınacak
    if (imageXfile == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ErrorDialog(
            message: "Lütfen Resim Ekleyiniz",
          );
        },
      );
    } else {
      if (passwordController.text == confirmPasswordController.text) {
        if (nameController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            confirmPasswordController.text.isNotEmpty &&
            emailController.text.isNotEmpty) {
          //start uploading

          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (c) {
                return const LoadingDialog(
                  message: "Registering Account",
                );
              });

          String fileName = DateTime.now().millisecondsSinceEpoch.toString();

          debugPrint(fileName.toString());

          fStorage.Reference reference = fStorage.FirebaseStorage.instance
              .ref()
              .child("users")
              .child(fileName);

          fStorage.UploadTask uploadTask = reference.putFile(
            File(imageXfile!.path),
          );

          fStorage.TaskSnapshot taskSnapshot =
              await uploadTask.whenComplete(() {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Picture Succesfully Installed..."),
            ));
          });

          await taskSnapshot.ref.getDownloadURL().then((url) {
            userImageUrl = url;
          });
          //firebase'e dosya yüklemede yararlanılabilir
          //https://stackoverflow.com/questions/51857796/flutter-upload-image-to-firebase-storage
          signUpWithEmail();
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ErrorDialog(
                message: "Bütün Alanları Doldurun!",
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ErrorDialog(
              message: "Şifreler Birbiri ile Uyuşmuyor!",
            );
          },
        );
      }
    }
  }

  void signUpWithEmail() async {
    try {
      User? currentUser;
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((auth) => currentUser = auth.user);
      if (currentUser != null) {
        saveDataToFirestore(currentUser!).then((value) {
          //todo oku https://medium.com/flutter-community/flutter-push-pop-push-1bb718b13c31
          Navigator.pop(context);
          Route newRoute = MaterialPageRoute(builder: (c) => const HomePage());
          Navigator.pushReplacement(context, newRoute);
          //oluştur değiştir git. gerideki sayfayı sil onun yerine bunu ekle.
          ///ModalRoute ta ekleme değil yer değiştitrme yapılır.
        });
      }
    } on Exception catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
            message: e.toString(),
          );
        },
      );
    }
  }

  Future saveDataToFirestore(User currentUser) async {
    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
      "uid": currentUser.uid,
      "email": currentUser.email,
      "name": nameController.text.trim(),
      "photoUrl": userImageUrl,
      "phone": phoneController.text.trim(),
      //todo ileride telefon numarası kaldırılmadığı için kod hata verebilir
      "status": "approved",
      "userCart": ["garbageValue"]
    });

    //save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!.setString("photoUrl", userImageUrl);
    await sharedPreferences!.setStringList("userCart", ["garbageValue"]);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                _getImage();
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundImage: imageXfile == null
                    ? null
                    : FileImage(File(imageXfile!.path)),
                child: imageXfile == null
                    ? Icon(
                        Icons.add_photo_alternate,
                        size: MediaQuery.of(context).size.width * 0.20,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: nameController,
              icondata: Icons.person,
              hintText: "İsmini Giriniz",
              isObsecre: false,
              enabled: true,
            ),
            CustomTextField(
              controller: emailController,
              icondata: Icons.email,
              hintText: " E Posta Adresini Giriniz",
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
            CustomTextField(
              controller: confirmPasswordController,
              icondata: Icons.lock,
              hintText: "Şifrenizi Doğrulayınız",
              isObsecre: true,
              enabled: true,
            ),
            CustomTextField(
              controller: phoneController,
              icondata: Icons.phone,
              hintText: "Telefon Numaranızı Giriniz",
              isObsecre: false,
              enabled: true,
            ),
            const SizedBox(height: 10),
            CustomButton(
              pressed: () {
                validate();
                // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //   content: Text("Sending Message"),
                // ));
              },
              buttonText: "Kayıt Ol",
            ),
          ],
        ),
      ),
    );
  }
}

//lokasyon işlemlerinde kullandığım kaynak kod
//https://protocoderspoint.com/flutter-get-current-location-address-from-latitude-longitude/
//     placeMarks = await GeocodingPlatform.instance.placemarkFromCoordinates(position.latitude, position.longitude,          localeIdentifier: "en");