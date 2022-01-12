import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_user/component/info_design.dart';
import 'package:online_shop_user/component/my_app_bar.dart';
import 'package:online_shop_user/model/item.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      "assets/slider/0.jpg",
      "assets/slider/1.jpg",
      "assets/slider/2.jpg",
      "assets/slider/3.jpg",
      "assets/slider/4.jpg",
      "assets/slider/5.jpg",
      "assets/slider/6.jpg",
      "assets/slider/7.jpg",
      "assets/slider/8.jpg",
      "assets/slider/9.jpg",
      "assets/slider/10.jpg",
      "assets/slider/11.jpg",
      "assets/slider/12.jpg",
      "assets/slider/13.jpg",
      "assets/slider/14.jpg",
      "assets/slider/15.jpg",
      "assets/slider/16.jpg",
      "assets/slider/17.jpg",
      "assets/slider/18.jpg",
      "assets/slider/19.jpg",
      "assets/slider/20.jpg",
      "assets/slider/21.jpg",
      "assets/slider/22.jpg",
      "assets/slider/23.jpg",
      "assets/slider/24.jpg",
      "assets/slider/25.jpg",
      "assets/slider/26.jpg",
      "assets/slider/27.jpg",
    ];

    return Scaffold(
      appBar: CustomAppBar(
        name: "",
        show: true,
        showAdminShiftOrders: false,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .3,
              width: MediaQuery.of(context).size.height,
              child: CarouselSlider(
                  items: items.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 1.0),
                          decoration: const BoxDecoration(color: Colors.amber),
                          child: Image.asset(
                            i,
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 300,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.decelerate,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  )),
            ),
            //SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate()),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("items")
                    .limit(15)
                    .orderBy("publishedDate", descending: true)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading...");
                  }
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1,
                      crossAxisCount: 2,
                    ),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      ItemModel model = ItemModel.fromJson(
                          snapshot.data.docs[index].data()
                              as Map<String, dynamic>);

                      return InfoDesign(
                        context: context,
                        model: model,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
//----------------------------------
      //     CustomScrollView(
      //   slivers: [
      //     SliverToBoxAdapter(
      //       child: SizedBox(
      //         height: MediaQuery.of(context).size.height * .3,
      //         width: MediaQuery.of(context).size.height,
      //         child: CarouselSlider(
      //             items: items.map((i) {
      //               return Builder(
      //                 builder: (BuildContext context) {
      //                   return Container(
      //                     width: MediaQuery.of(context).size.width,
      //                     margin: const EdgeInsets.symmetric(horizontal: 1.0),
      //                     decoration: const BoxDecoration(color: Colors.amber),
      //                     child: Image.asset(
      //                       i,
      //                       fit: BoxFit.fill,
      //                     ),
      //                   );
      //                 },
      //               );
      //             }).toList(),
      //             options: CarouselOptions(
      //               height: 400,
      //               aspectRatio: 16 / 9,
      //               viewportFraction: 0.8,
      //               initialPage: 0,
      //               enableInfiniteScroll: true,
      //               reverse: false,
      //               autoPlay: true,
      //               autoPlayInterval: const Duration(seconds: 3),
      //               autoPlayAnimationDuration:
      //                   const Duration(milliseconds: 800),
      //               autoPlayCurve: Curves.decelerate,
      //               enlargeCenterPage: true,
      //               scrollDirection: Axis.horizontal,
      //             )),
      //       ),
      //     ),
      //     SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate()),
      //     SizedBox(
      //       height: 250,
      //       child: StreamBuilder<QuerySnapshot>(
      //         stream: FirebaseFirestore.instance
      //             .collection("items")
      //             .limit(15)
      //             .orderBy("publishedDate", descending: true)
      //             .snapshots(),
      //         builder: (BuildContext context, AsyncSnapshot snapshot) {
      //           if (snapshot.hasError) {
      //             return const Text('Something went wrong');
      //           }

      //           if (snapshot.connectionState == ConnectionState.waiting) {
      //             return const Text("Loading");
      //           }

      //           return GridView.builder(
      //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 1,
      //             ),
      //             itemCount: snapshot.data.docs.length,
      //             itemBuilder: (BuildContext context, int index) {
      //               ItemModel model =
      //                   ItemModel.fromJson(snapshot.data.docs[index].data());
      //               return sourceInfo(model, context);
      //             },
      //           );
      //         },
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget sourceInfo(ItemModel model, BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Image.network(
              model.thumbnailUrl,
              width: 140.0,
              height: 140.0,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: const TextStyle(color: Colors.black, fontSize: 14.0),
                ),

                Text(
                  model.shortInfo,
                  style: const TextStyle(color: Colors.black54, fontSize: 12.0),
                ),
                const SizedBox(height: 20.0),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.pink,
                  ),
                  width: 40.0,
                  height: 40.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "50%",
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "OFF",
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r"Origional Price: € " +
                          model.price /*+ model.price*/ .toString(),
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        children: [
                          Text(
                            r"New Price: € " + model.price.toString(),
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                //to implement the cart item aad/remove feature
              ],
            ),
          ),
        ],
      ),
    );
  }
}
