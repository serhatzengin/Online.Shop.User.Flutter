import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_user/component/my_app_bar.dart';
import 'package:online_shop_user/component/order_card.dart';
import 'package:online_shop_user/global/global.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(show: false, name: "Siparişlerim"),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(sharedPreferences!.getString("uid"))
                  .collection("orders")
                  .snapshots(),
              builder: (c, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text("Yükleniyor..."));
                }

                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                        "Burası boş duruyor hemen bir sipariş vermelisin :)"),
                  );
                }

                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (c, index) {
                          return FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance
                                .collection("items")
                                .where("shortInfo",
                                    whereIn: snapshot.data!.docs[index]
                                        ["productIDs"])
                                .get(),
                            builder: (c, snap) {
                              return snap.hasData
                                  ? OrderCard(
                                      itemCount: snap.data!.docs.length,
                                      data: snap.data!.docs,
                                      orderID: snapshot.data!.docs[index].id,
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator());
                            },
                          );
                        },
                      )
                    : const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
