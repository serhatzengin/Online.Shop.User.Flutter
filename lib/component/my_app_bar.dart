import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:online_shop_user/global/global.dart';
import 'package:online_shop_user/view/home/admin/admin_shift_orders.dart';
import 'package:online_shop_user/view/home/cart/cart_view.dart';
import 'package:online_shop_user/view/home/cart/cart_view_model.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  bool show;
  bool? showAdminShiftOrders;
  final String name;

  @override
  final Size preferredSize;

  CustomAppBar({
    Key? key,
    this.showAdminShiftOrders,
    required this.show,
    required this.name,
  })  : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xffffffff),
      title: Text(name),
      // leading: IconButton(
      //   icon: const Icon(Icons.arrow_back_ios),
      //   onPressed: () => Navigator.pop(context),
      // ),
      actions: [
        Row(
          children: [
            show == true ? const Icon(Icons.search) : const Icon(null),
            Stack(
              children: [
                IconButton(
                    onPressed: () {
                      if (sharedPreferences!
                              .getStringList("userCart")!
                              .length ==
                          1) {
                        Fluttertoast.showToast(
                            msg:
                                "Alışveriş Spetiniz Boş Lütfen Ürün Ekleyiniz");
                      } else {
                        Route route =
                            MaterialPageRoute(builder: (c) => const CartPage());
                        Navigator.pushReplacement(context, route);
                      }
                    },
                    icon: const Icon(Icons.shopping_cart)),
                const Icon(Icons.brightness_1, size: 20, color: Colors.green),
                Consumer<CartViewModel>(
                  builder: (context, counter, _) {
                    return Text(
                      (sharedPreferences!.getStringList("userCart")!.length - 1)
                          .toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ],
            )
          ],
        )
      ],
      //drawer simgesini görmek istiyorasn leading i açıklama satırı yap
      leading: showAdminShiftOrders == true
          ? IconButton(
              onPressed: () {
                Route route =
                    MaterialPageRoute(builder: (c) => const AdminShiftOrders());
                Navigator.pushReplacement(context, route);
              },
              icon: const Icon(Icons.border_color, color: Colors.black))
          : const Icon(null),
      automaticallyImplyLeading: true,
    );
  }
}
