import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:online_shop_user/model/address.dart';
import 'package:online_shop_user/view/home/adress/address_view_model.dart';
import 'package:online_shop_user/view/home/payment/payment_page.dart';

import 'wide_button.dart';

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
