import 'package:flutter/material.dart';
import 'package:online_shop_user/view/home/search/search_view.dart';

class SearchBoxDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      InkWell(
        onTap: () {
          Route route =
              MaterialPageRoute(builder: (c) => const SearchProduct());
          Navigator.pushReplacement(context, route);
        },
        child: Container(
          color: Colors.orange,
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: Row(
            children: const [Icon(Icons.search), Text("Arayın!")],
          ),
        ),
      );

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
