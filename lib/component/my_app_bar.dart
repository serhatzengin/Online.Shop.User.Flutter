import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:online_shop_user/view/home/cart/cart_view.dart';
import 'package:online_shop_user/view/home/cart/cart_view_model.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  bool show;
  final String name;

  @override
  final Size preferredSize;

  CustomAppBar({Key? key, required this.show, required this.name})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xffffffff),
      title: Text(name),
      // leading: IconButton(
      //   icon: const Icon(Icons.arrow_back_ios),
      //   onPressed: () => Navigator.of(context).pop(),
      // ),
      actions: [
        Row(
          children: [
            show == true ? const Icon(Icons.search) : const Icon(null),
            Stack(
              children: [
                IconButton(
                    onPressed: () {
                      Route route =
                          MaterialPageRoute(builder: (c) => const CartPage());
                      Navigator.pushReplacement(context, route);
                    },
                    icon: const Icon(Icons.shopping_cart)),
                const Icon(Icons.brightness_1, size: 20, color: Colors.green),
                Consumer<CartViewModel>(
                  builder: (context, counter, child) {
                    return Text(counter.count.toString());
                  },
                )
              ],
            )
          ],
        )
      ],
      automaticallyImplyLeading: true,
    );
  }
}
