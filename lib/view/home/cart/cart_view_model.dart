import 'package:flutter/foundation.dart';
import 'package:online_shop_user/config/config.dart';

class CartViewModel extends ChangeNotifier {
  int _counter = EcommerceApp.sharedPreferences!
          .getStringList(EcommerceApp.userCartList)!
          .length -
      1;

  int get count => _counter;
}
