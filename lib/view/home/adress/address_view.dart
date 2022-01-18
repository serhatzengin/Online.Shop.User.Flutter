import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:online_shop_user/component/my_app_bar.dart';
import 'package:online_shop_user/component/wide_button.dart';
import 'package:online_shop_user/global/global.dart';
import 'package:online_shop_user/model/address.dart';

import 'add_address_view.dart';
import 'address_view_model.dart';
import 'payment_page.dart';

class AddressPage extends StatefulWidget {
  final double? totalAmount;

  const AddressPage({
    Key? key,
    this.totalAmount,
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

class AddressCard extends StatelessWidget {
  final AddressModel model;
  final String addressId;
  final double totalAmount;
  final int currentIndex;
  final int value;
  const AddressCard({
    Key? key,
    required this.model,
    required this.addressId,
    required this.totalAmount,
    required this.currentIndex,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () => Provider.of<AddressChanger>(context, listen: false)
          .displayResult(value),
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  value: value,
                  groupValue: currentIndex,
                  onChanged: (int? val) {
                    Provider.of<AddressChanger>(context, listen: false)
                        .displayResult(val!);
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      width: screenWidth * 0.8,
                      child: Table(
                        children: [
                          TableRow(children: [
                            const KeyText(
                              msg: "Adres İsmi",
                            ),
                            Text(model.name!),
                          ]),
                          TableRow(children: [
                            const KeyText(
                              msg: "Telefon Numarası",
                            ),
                            Text(model.phoneNumber!),
                          ]),
                          TableRow(children: [
                            const KeyText(
                              msg: "Daire Numarası ",
                            ),
                            Text(model.flatNumber!),
                          ]),
                          TableRow(children: [
                            const KeyText(
                              msg: "Şehir",
                            ),
                            Text(model.city!),
                          ]),
                          TableRow(children: [
                            const KeyText(
                              msg: "Ülke",
                            ),
                            Text(model.state!),
                          ]),
                          TableRow(
                            children: [
                              const KeyText(
                                msg: "Posta Kodu",
                              ),
                              Text(model.postaCode!),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            value == Provider.of<AddressChanger>(context).count
                ? WideButton(
                    message: "İlerle",
                    onPressed: () {
                      Route route = MaterialPageRoute(
                          builder: (c) => PaymentPage(
                                addressId: addressId,
                                totalAmount: totalAmount,
                              ));
                      Navigator.push(context, route);
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class KeyText extends StatelessWidget {
  final String msg;

  const KeyText({
    Key? key,
    required this.msg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
