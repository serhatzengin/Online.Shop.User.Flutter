import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:online_shop_user/component/custom_button_icon.dart';
import 'package:online_shop_user/component/custom_text_field.dart';
import 'package:online_shop_user/component/loading_dialog.dart';
import 'package:online_shop_user/component/my_app_bar.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin<UploadPage> {
  @override
  bool get wantKeepAlive => true;

  final ImagePicker _picker = ImagePicker();
  //galeriden ya da kameradan resim seçmeye yarar
  XFile? imageXfile;
  //seçilen resim atanır
  String userImageUrl = "";

  TextEditingController desctriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController shortInfoController = TextEditingController();
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    return imageXfile == null
        ? displayAdminHomeScreen()
        : displayAdminUploadScreen();
  }

  displayAdminHomeScreen() {
    return Scaffold(
      appBar: CustomAppBar(
        show: false,
        name: "AdminHomeScreen",
        showAdminShiftOrders: true,
      ),
      body: getAdminHomeScreenBody(),
    );
  }

  displayAdminUploadScreen() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        title: const Text("Yeni Ürün"),
        actions: [
          TextButton(
              onPressed: () {
                debugPrint("Tıkladı");
              },
              child: const Text("Ekle"))
        ],
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: 230,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(imageXfile!.path)),
                    ),
                  ),
                ),

                ///Widget içindeki görüntüyü göstermek için Xfile görüntünüzü
                ///Dosya görüntüsüne dönüştürmek için bu kodu kullanabilirsiniz.
              ),
            ),
            CustomTextField(
              keyboardType: TextInputType.text,
              controller: shortInfoController,
              hintText: "Short Info",
              enabled: true,
              isObsecre: false,
              icondata: Icons.perm_device_info,
            ),
            const Divider(color: Colors.pink),
            CustomTextField(
              keyboardType: TextInputType.text,
              controller: titleController,
              hintText: "Başlık",
              enabled: true,
              isObsecre: false,
              icondata: Icons.perm_device_info,
            ),
            const Divider(color: Colors.pink),
            CustomTextField(
              keyboardType: TextInputType.text,
              controller: desctriptionController,
              hintText: "Açıklama",
              enabled: true,
              isObsecre: false,
              icondata: Icons.perm_device_info,
            ),
            const Divider(color: Colors.pink),
            CustomTextField(
                keyboardType: TextInputType.number,
                controller: priceController,
                hintText: "Ücret",
                enabled: true,
                isObsecre: false,
                icondata: Icons.money),
            CustomButtonIcon(
              buttonText: "Temizle",
              icon: Icons.clear,
              pressed: () {
                clearForm();
              },
            ),
            CustomButtonIcon(
              buttonText: "Ekle",
              icon: Icons.add,
              pressed: () {
                uploading ? null : uploadImageAndSaveItemInfo();
              },
            ),
          ],
        ),
      ),
    );
  }

  clearForm() {
    setState(() {
      imageXfile = null;
      desctriptionController.clear();
      priceController.clear();
      titleController.clear();
      shortInfoController.clear();
    });
  }

  uploadImageAndSaveItemInfo() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const LoadingDialog(
          message: "Ürün Ekleniyor ",
        );
      },
    );

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    debugPrint(fileName.toString());

    fStorage.Reference reference =
        fStorage.FirebaseStorage.instance.ref().child("items").child(fileName);

    fStorage.UploadTask uploadTask = reference.putFile(
      File(imageXfile!.path),
    );

    fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Picture Succesfully Installed..."),
      ));
    });

    await taskSnapshot.ref.getDownloadURL().then((url) {
      userImageUrl = url;
    });
    saveItemInfo();
  }

  Future saveItemInfo() async {
    FirebaseFirestore.instance.collection("items").doc(productId).set({
      "shortInfo": shortInfoController.text.trim(),
      "longDescription": desctriptionController.text.trim(),
      "price": int.parse(priceController.text),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": userImageUrl,
      "title": titleController.text.trim(),
    });

    setState(() {
      Navigator.pop(context);
      imageXfile = null;
      productId = DateTime.now().millisecondsSinceEpoch.toString();
      desctriptionController.clear();
      priceController.clear();
      titleController.clear();
      shortInfoController.clear();
    });
  }

  Future<void> capturePhotoWithCamera() async {
    Navigator.pop(context);
    try {
      imageXfile = await _picker.pickImage(source: ImageSource.camera);

      setState(() {
        imageXfile;
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  Future<void> takeImageFromGallery() async {
    Navigator.pop(context);
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

  getAdminHomeScreenBody() {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.shop_two, color: Colors.white, size: 200),
          ElevatedButton(
            child: const Text("Add New Items"),
            onPressed: () {
              takeImage(context);
            },
          )
        ],
      ),
    );
  }

  takeImage(context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (c) {
          return SimpleDialog(
            title: const Text("Item Image"),
            children: [
              SimpleDialogOption(
                child: const Text("Capture With Camera"),
                onPressed: () {
                  capturePhotoWithCamera();
                },
              ),
              SimpleDialogOption(
                child: const Text("Take Image From Gallery"),
                onPressed: () {
                  takeImageFromGallery();
                },
              ),
              SimpleDialogOption(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

//todo logotu işleminde direk giriş sayfasına yönlendir
