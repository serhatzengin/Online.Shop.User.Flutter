import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:online_shop_user/component/address_card.dart';
import 'package:online_shop_user/component/my_app_bar.dart';
import 'package:online_shop_user/global/global.dart';
import 'package:online_shop_user/model/address.dart';

import 'add_address_view.dart';
import 'address_view_model.dart';

class AddressPage extends StatefulWidget {
  final double? totalAmount;

  const AddressPage({
    Key? key,
    this.totalAmount = 0,
  }) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(show: true, name: "Adres Seç"),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Route route = MaterialPageRoute(builder: (c) => AddAdress());
          Navigator.pushReplacement(context, route);
        },
        label: const Text("Yeni Adres Ekle"),
        icon: const Icon(Icons.add_location),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Adres Seç",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            Consumer<AddressChanger>(
              builder: (context, address, c) {
                return Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(sharedPreferences!.getString("uid"))
                        .collection("userAddress")
                        .snapshots(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? const CircularProgressIndicator()
                          : snapshot.data!.docs.isEmpty
                              ? noAddressCard()
                              : ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return AddressCard(
                                      currentIndex: address.count,
                                      value: index,
                                      addressId: snapshot.data!.docs[index].id,
                                      //buraya bak burada hata olabilir
                                      totalAmount: widget.totalAmount!,
                                      model: AddressModel.fromJson(
                                          snapshot.data!.docs[index].data()
                                              as Map<String, dynamic>),
                                    );
                                  },
                                );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  noAddressCard() {
    return Card(
      color: Colors.pink.withOpacity(0.5),
      child: Container(
        height: 100.0,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.add_location,
              color: Colors.white,
            ),
            Text(
                "No shipment address has been saved.Please add your shipment \n Address so that we can deliever product."),
          ],
        ),
      ),
    );
  }
}
