import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_user/component/my_app_bar.dart';
import 'package:online_shop_user/global/global.dart';

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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
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
                    height: 400,
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
          ),

          // StreamBuilder<QuerySnapshot>(
          //   stream: FirebaseFirestore.instance.collection("users").snapshots(),
          //   builder: (BuildContext context, AsyncSnapshot snapshot) {
          //     if (snapshot.hasError) {
          //       return const Text('Something went wrong');
          //     }

          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Text("Loading");
          //     }
          //     return

          //         // SliverStaggeredGrid.countBuilder(
          //         //   crossAxisCount: 1,
          //         //   staggeredTileBuilder: (context) => const StaggeredTile.fit(1),
          //         //   itemBuilder: (contex, index) {
          //         //     Sellers sModel = Sellers.fromJson(snapshot.data!.docs[index]
          //         //         .data()! as Map<String, dynamic>);

          //         //     return InfoDesign(
          //         //       context: context,
          //         //       model: sModel,
          //         //     );
          //         //   },
          //         //   itemCount: snapshot.data!.docs.length,
          //         // );

          //         //-------
          //         GridView.builder(
          //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 1,
          //       ),
          //       itemCount: snapshot.data!.docs.length,
          //       itemBuilder: (BuildContext context, int index) {
          //         Sellers sModel = Sellers.fromJson(snapshot.data!.docs[index]
          //             .data()! as Map<String, dynamic>);
          //         return InfoDesign(
          //           context: context,
          //           model: sModel,
          //         );
          //       },
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
