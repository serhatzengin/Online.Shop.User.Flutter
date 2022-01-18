import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final String addressId;
  final double? totalAmount;
  const PaymentPage({
    Key? key,
    required this.addressId,
    this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(),
      ),
    );
  }
}
