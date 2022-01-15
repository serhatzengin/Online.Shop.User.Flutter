import 'package:flutter/material.dart';
import 'package:online_shop_user/component/my_app_bar.dart';

import 'add_adress_view.dart';

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
          children: const [],
        ),
      ),
    );
  }

  noAddressCard() {
    return const Card();
  }
}

class AddressCard extends StatefulWidget {
  const AddressCard({Key? key}) : super(key: key);

  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    return const InkWell();
  }
}

class KeyText extends StatelessWidget {
  const KeyText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("");
  }
}
