import 'package:flutter/foundation.dart';
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

  double _totalAmount = 0;

  double get totalAmount => _totalAmount;

  display(double no) async {
    _totalAmount = no;

    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
