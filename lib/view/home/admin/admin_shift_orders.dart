import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_user/view/home/admin/admin_order_card.dart';

import '../../../component/my_app_bar.dart';

class AdminShiftOrders extends StatefulWidget {
  const AdminShiftOrders({Key? key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<AdminShiftOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(show: false, name: "Siparişlerim"),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("orders").snapshots(),
              builder: (c, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text("Yükleniyor..."));
                }

                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("Yeni Sipariş Aldığında Burada Gözükecek :)"),
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
                                  ? AdminOrderCard(
                                      itemCount: snap.data!.docs.length,
                                      data: snap.data!.docs,
                                      orderID: snapshot.data!.docs[index].id,
                                      orderBy: snapshot.data!.docs[index]
                                          ["orderBy"],
                                      addressID: snapshot.data!.docs[index]
                                          ["addressID"],
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
