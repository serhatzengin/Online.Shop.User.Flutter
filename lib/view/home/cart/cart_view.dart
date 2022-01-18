import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_shop_user/view/home/adress/address_view.dart';
import 'package:provider/provider.dart';

import 'package:online_shop_user/component/info_design.dart';
import 'package:online_shop_user/component/my_app_bar.dart';
import 'package:online_shop_user/global/global.dart';
import 'package:online_shop_user/model/item.dart';

import 'cart_view_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalAmount = 0; //eğer hata verirse null olabilir değere çevir

  @override
  void initState() {
    super.initState();

    totalAmount = 0;
    Provider.of<CartViewModel>(context, listen: false).display(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        name: "",
        show: true,
        showAdminShiftOrders: false,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (sharedPreferences!.getStringList("userCart")!.length == 1) {
            Fluttertoast.showToast(msg: "Sepetiniz Boş, Ürün Ekleyiniz :)");
          } else {
            Route route = MaterialPageRoute(
                builder: (c) => AddressPage(totalAmount: totalAmount));
            Navigator.pushReplacement(context, route);
          }
        },
        label: const Text("Ödemeye Geç"),
        icon: const Icon(Icons.add_location),
      ),
      body: Center(
        child: Column(
          children: [
            Consumer<CartViewModel>(
              builder: (context, counter, _) {
                return Text(counter.count.toString());
              },
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("items")
                    .where("shortInfo",
                        whereIn: sharedPreferences!.getStringList("userCart"))
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Upps Birşeyler Yanlış Gİtti');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Yükleniyor...");
                  }

                  if (snapshot.data.docs.length == 0) {
                    return const Center(
                      child: Text("Sepertiniz Boş Ürün Eklemeye Başlayınız :)"),
                    );
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1,
                      crossAxisCount: 2,
                    ),
                    itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.data.docs.length > 0) {
                        ItemModel model = ItemModel.fromJson(
                            snapshot.data.docs[index].data()
                                as Map<String, dynamic>);

                        if (index == 0) {
                          totalAmount = 0;
                          totalAmount = (model.price! + totalAmount);
                        } else {
                          totalAmount = (model.price! + totalAmount);
                        }

                        if (snapshot.data.docs.length - 1 == index) {
                          WidgetsBinding.instance!.addPostFrameCallback((t) {
                            Provider.of<CartViewModel>(
                              context,
                              listen: false,
                            ).display(totalAmount);
                          });
                        }

                        return InfoDesign(
                          context: context,
                          model: model,
                        );
                      } else {
                        return const Text(
                            "Sepertiniz Boş Ürün Eklemeye Başlayınız :(");
                      }
                    },
                  );
                },
              ),
            ),
            Consumer<CartViewModel>(
              builder: (context, cartviewmodel, child) {
                return cartviewmodel.count == 0
                    ? Container()
                    : Text(
                        "Toplam Fiyat € ${cartviewmodel.totalAmount.toString()}");
              },
            ),
          ],
        ),
      ),
    );
  }
}
