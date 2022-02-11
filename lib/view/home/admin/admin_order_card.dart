import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../model/item.dart';
import 'admin _order_detail.dart';

int counter = 0;

class AdminOrderCard extends StatelessWidget {
  final int itemCount;
  final List<DocumentSnapshot> data;
  final String orderID;
  final String addressID;
  final String orderBy;

  const AdminOrderCard({
    Key? key,
    required this.itemCount,
    required this.data,
    required this.orderID,
    required this.addressID,
    required this.orderBy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Route route;

        if (counter == 0) {
          counter = counter + 1;

          route = MaterialPageRoute(
            builder: (context) => AdminOrderDetail(
                orderID: orderID, orderBy: orderBy, addressID: addressID),
          );
          Navigator.push(context, route);
        }
      },
      child: Card(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: itemCount,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (c, index) {
            ItemModel model =
                ItemModel.fromJson(data[index].data() as Map<String, dynamic>);
            return Row(
              children: [
                Expanded(
                    child: Image.network(model.thumbnailUrl,
                        height: 150, width: 150)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15.0),
                      Text(
                        model.title,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 14.0),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        model.shortInfo,
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 12.0),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    r"Total Price: ",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Text(
                                    "€ ",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 16.0),
                                  ),
                                  Text(
                                    (model.price).toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(height: 5.0, color: Colors.pink),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
