import 'package:flutter/material.dart';

import 'package:online_shop_user/model/sellers.dart';

class InfoDesign extends StatefulWidget {
  Sellers? model;
  BuildContext context;

  InfoDesign({this.model, required this.context});

  @override
  _InfoDesignState createState() => _InfoDesignState();
}

class _InfoDesignState extends State<InfoDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        height: 265,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Divider(height: 4, thickness: 3, color: Colors.grey[300]),
            Image.network(widget.model!.sellerAvatarUrl!)
          ],
        ),
      ),
    );
  }
}
