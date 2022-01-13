import 'package:flutter/material.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
