import 'package:flutter/foundation.dart';
import 'package:online_shop_user/config/config.dart';
import 'package:online_shop_user/global/global.dart';

class CartViewModel extends ChangeNotifier {
  int counter = sharedPreferences!.getStringList("userCart")!.length - 1;
  int get count => counter;

  Future<void> displayResult() async {
    counter = sharedPreferences!.getStringList("userCart")!.length - 1;

    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
