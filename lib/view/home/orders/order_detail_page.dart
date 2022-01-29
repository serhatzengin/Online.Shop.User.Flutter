import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:online_shop_user/component/address_card.dart';
import 'package:online_shop_user/component/custom_button.dart';
import 'package:online_shop_user/component/order_card.dart';

import 'package:online_shop_user/global/global.dart';
import 'package:online_shop_user/model/address.dart';
import 'package:online_shop_user/view/home/homepage.dart';
import 'package:online_shop_user/view/splash/splash.dart';

String getOrderId = "";

class OrderDetailPage extends StatelessWidget {
  final String orderID;
  const OrderDetailPage({
    Key? key,
    required this.orderID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getOrderId = orderID;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection("users")
                .doc(sharedPreferences!.getString("uid"))
                .collection("orders")
                .doc(orderID)
                .get(),
            builder: (c, snapshot) {
              Map<String, dynamic> dataMap;

              if (snapshot.hasData) {
                dataMap = snapshot.data!.data() as Map<String, dynamic>;

                return Column(
                  children: [
                    DeliveredOrNot(
                      status: dataMap["isSuccess"],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "€ " + dataMap["totalAmount"].toString(),
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text("Order ID: " + getOrderId),
                    ),
                    Text(
                      "Sipariş Tarihi: " +
                          DateFormat("dd MMMM, yyyy - hh:mm aa").format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(dataMap["orderTime"]))),
                      style:
                          const TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                    const Divider(height: 2.0),
                    FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection("items")
                          .where("shortInfo", whereIn: dataMap["productIDs"])
                          .get(),
                      builder: (c, dataSnapshot) {
                        return dataSnapshot.hasData
                            ? OrderCard(
                                orderID: sharedPreferences!
                                    .getString("uid")
                                    .toString(),
                                itemCount: dataSnapshot.data!.docs.length,
                                data: dataSnapshot.data!.docs,
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              );
                      },
                    ),
                    const Divider(
                      height: 2.0,
                    ),
                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection("users")
                          .doc(sharedPreferences!.getString("uid"))
                          .collection("userAddress")
                          .doc(dataMap["addressID"])
                          .get(),
                      builder: (c, snap) {
                        return snap.hasData
                            ? ShippingDetails(
                                model: AddressModel.fromJson(
                                    snap.data!.data() as Map<String, dynamic>),
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              );
                      },
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class DeliveredOrNot extends StatelessWidget {
  final bool status;

  const DeliveredOrNot({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String msg;
    IconData iconData = Icons.done;

    status ? iconData == Icons.done : iconData == Icons.cancel;
    status ? msg = "Sipariş Başarıyla Verildi" : msg = "Sipariş  Verilemedi";

    return SizedBox(
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              SystemNavigator.pop();
            },
            child: const Icon(
              Icons.arrow_drop_down_circle,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            "Siparişin durumu: " + msg,
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(
            width: 5.0,
          ),
          CircleAvatar(
            radius: 8.0,
            backgroundColor: Colors.grey,
            child: Center(
              child: Icon(
                iconData,
                color: Colors.white,
                size: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShippingDetails extends StatelessWidget {
  final AddressModel model;
  const ShippingDetails({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Text(
            "Shipment Details:",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90.0, vertical: 5.0),
          width: screenWidth,
          child: Table(
            children: [
              TableRow(children: [
                const KeyText(
                  msg: "Name",
                ),
                Text(model.name.toString()),
              ]),
              TableRow(children: [
                const KeyText(
                  msg: "Phone Number",
                ),
                Text(model.phoneNumber.toString()),
              ]),
              TableRow(children: [
                const KeyText(
                  msg: "Flat Number",
                ),
                Text(model.flatNumber.toString()),
              ]),
              TableRow(children: [
                const KeyText(
                  msg: "City",
                ),
                Text(model.city.toString()),
              ]),
              TableRow(children: [
                const KeyText(
                  msg: "State",
                ),
                Text(model.state.toString()),
              ]),
              TableRow(children: [
                const KeyText(
                  msg: "Pin Code",
                ),
                Text(model.postaCode.toString()),
              ]),
            ],
          ),
        ),
        CustomButton(
          buttonText: "Sipariş Teslim Alındı / Onayla",
          pressed: () {
            confirmedUserOrderReceived(context, getOrderId);
          },
        ),
      ],
    );
  }

  confirmedUserOrderReceived(BuildContext context, String mOrderId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .doc(mOrderId)
        .delete();

    getOrderId = "";

    Route route = MaterialPageRoute(builder: (c) => const Splash());
    Navigator.pushReplacement(context, route);

    Fluttertoast.showToast(msg: "Siparişi Teslim Aldım Onaylıyorum. ");
    //todo iki farklı sipariş onaylanamıyor.
  }
}
