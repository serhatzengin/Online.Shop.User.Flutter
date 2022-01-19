import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_shop_user/component/my_app_bar.dart';
import 'package:online_shop_user/global/global.dart';
import 'package:online_shop_user/view/home/cart/cart_view_model.dart';
import 'package:provider/provider.dart';

import '../homepage.dart';

class PaymentPage extends StatefulWidget {
  final String addressId;
  final double? totalAmount;
  const PaymentPage({
    Key? key,
    required this.addressId,
    this.totalAmount,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(show: false, name: "Siparişi Onayla"),
      body: Center(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Image.asset("images/cash.png"),
                // ),
                const SizedBox(
                  height: 10.0,
                ),
                TextButton(
                  onPressed: () {
                    addOrderDetails();
                  },
                  child: const Text(
                    "Sipariş Ver",
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  addOrderDetails() {
    writeOrderDetailsForUser({
      "addressID": widget.addressId,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIDs": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Cash on Delivery",
      "orderTime": DateTime.now().millisecondsSinceEpoch.toString(),
      "isSuccess": true,
    });

    writeOrderDetailsForAdmin({
      "addressID": widget.addressId,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIDs": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Cash on Delivery",
      "orderTime": DateTime.now().millisecondsSinceEpoch.toString(),
      "isSuccess": true,
    }).whenComplete(() => {emptyCartNow()});
  }

  emptyCartNow() {
    sharedPreferences!.setStringList("userCart", ["garbageValue"]);
    List<String> tempList =
        sharedPreferences!.getStringList("userCart")!.cast<String>();

    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .update({
      "userCart": tempList,
    }).then((value) {
      sharedPreferences!.setStringList("userCart", tempList);
      Provider.of<CartViewModel>(context, listen: false).displayResult();
    });

    Fluttertoast.showToast(
        msg: "Congratulations, your Order has been placed successfully.");

    Route route = MaterialPageRoute(builder: (c) => const HomePage());
    Navigator.pushReplacement(context, route);
  }

  Future writeOrderDetailsForUser(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .doc(sharedPreferences!.getString("uid")! + data["orderTime"])
        .set(data);
  }

  Future writeOrderDetailsForAdmin(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(sharedPreferences!.getString("uid")! + data['orderTime'])
        .set(data);
  }
}
