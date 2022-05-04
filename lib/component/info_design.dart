import 'package:flutter/material.dart';

import 'package:online_shop_user/model/item.dart';
import 'package:online_shop_user/view/home/mainpage/detail_page.dart';

class InfoDesign extends StatelessWidget {
  ItemModel? model;
  BuildContext context;
  final Function? onPressed;
  InfoDesign({
    Key? key,
    this.model,
    required this.context,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Route route = MaterialPageRoute(
              builder: (c) => DetailPage(
                    itemModel: model,
                  ));
          Navigator.pushReplacement(context, route);
        },
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.network(
                model!.thumbnailUrl,
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
                    model!.title,
                    style: const TextStyle(color: Colors.black, fontSize: 14.0),
                  ),

                  Text(
                    model!.shortInfo,
                    style:
                        const TextStyle(color: Colors.black54, fontSize: 12.0),
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
                          "%50",
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
                  Text(
                    r"Old Price: € " + model!.price.toString(),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      r"New Price: € " + model!.price.toString(),
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  //to implement the cart item aad/remove feature
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
