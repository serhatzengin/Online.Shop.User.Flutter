import 'package:flutter/material.dart';
import 'package:online_shop_user/component/custom_button.dart';
import 'package:online_shop_user/component/custom_drawer.dart';
import 'package:online_shop_user/component/my_app_bar.dart';

import 'package:online_shop_user/model/item.dart';

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);

class DetailPage extends StatelessWidget {
  final ItemModel? itemModel;

  const DetailPage({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int quantityOfItems = 1;

    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        show: false,
        name: itemModel!.title,
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: SizedBox(
                      width: 250,
                      height: 250,
                      child: Image.network(itemModel!.thumbnailUrl)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemModel!.title,
                      style: boldTextStyle,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      itemModel!.longDescription,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "€ " + itemModel!.price.toString(),
                      style: boldTextStyle,
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ],
            ),
            CustomButton(
              buttonText: "Sepete Ekle",
              pressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
