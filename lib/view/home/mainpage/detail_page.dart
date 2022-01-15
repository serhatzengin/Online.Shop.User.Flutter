import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:online_shop_user/component/custom_button.dart';
import 'package:online_shop_user/component/my_app_bar.dart';
import 'package:online_shop_user/global/global.dart';
import 'package:online_shop_user/model/item.dart';
import 'package:online_shop_user/view/home/cart/cart_view_model.dart';
import 'package:online_shop_user/view/home/homepage.dart';

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);

class DetailPage extends StatefulWidget {
  final ItemModel? itemModel;

  const DetailPage({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late double totalAmount;

  @override
  void initState() {
    super.initState();

    totalAmount = 0;
    Provider.of<CartViewModel>(context, listen: false).display(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        show: false,
        name: widget.itemModel!.title,
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: SizedBox(
                      width: 250,
                      height: 250,
                      child: Image.network(widget.itemModel!.thumbnailUrl)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.itemModel!.title,
                      style: boldTextStyle,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      widget.itemModel!.longDescription,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "€ " + widget.itemModel!.price.toString(),
                      style: boldTextStyle,
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ],
            ),
            CustomButton(
              buttonText: "Sepete Ekle",
              pressed: () {
                checkItemInCart(widget.itemModel!.shortInfo, context);
                Route route =
                    MaterialPageRoute(builder: (c) => const HomePage());
                Navigator.pushReplacement(context, route);
              },
            ),
            CustomButton(
              buttonText: "Anasayfaya Git",
              pressed: () {
                Route route =
                    MaterialPageRoute(builder: (c) => const HomePage());
                Navigator.pushReplacement(context, route);
              },
            ),
            CustomButton(
              buttonText: "Sepetten Sil",
              pressed: () {
                checkItemInCartRemove(widget.itemModel!.shortInfo, context);
                Route route =
                    MaterialPageRoute(builder: (c) => const HomePage());
                Navigator.pushReplacement(context, route);
              },
            ),
          ],
        ),
      ),
    );
  }

  void checkItemInCart(String shortInfoAsID, BuildContext context) {
    sharedPreferences!.getStringList("userCart")!.contains(shortInfoAsID)
        ? Fluttertoast.showToast(msg: "Item is already in Cart.")
        : addItemToCart(shortInfoAsID, context);
  }

  addItemToCart(String shortInfoAsID, BuildContext context) {
    List<String> tempCartList =
        sharedPreferences!.getStringList("userCart")!.cast<String>();
    tempCartList.add(shortInfoAsID);

    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .update({"userCart": tempCartList}).then((value) {
      sharedPreferences!.setStringList("userCart", tempCartList);
    });

    sharedPreferences!.setStringList("userCart", tempCartList);

    Provider.of<CartViewModel>(context, listen: false).displayResult();
  }

  void checkItemInCartRemove(String shortInfoAsID, BuildContext context) {
    sharedPreferences!.getStringList("userCart")!.contains(shortInfoAsID)
        ? removeItemFromUserCart(shortInfoAsID, context)
        : Fluttertoast.showToast(msg: "Ürün Sepette Ekli Değil");
  }

  removeItemFromUserCart(String shortInfoAsId, BuildContext context) {
    List<String> tempCartList =
        sharedPreferences!.getStringList("userCart")!.cast<String>();
    tempCartList.remove(shortInfoAsId);

    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .update({
      "userCart": tempCartList,
    }).then((v) {
      Fluttertoast.showToast(msg: "Ürün başarılı şekilde silindi");

      sharedPreferences!.setStringList("userCart", tempCartList);

      Provider.of<CartViewModel>(context, listen: false).displayResult();

      totalAmount = 0;
    });
  }
}

//cached_network_image ile resimler gösterilecek