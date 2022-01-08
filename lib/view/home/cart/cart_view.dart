import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_view_model.dart';

// class CartPage extends StatefulWidget {
//   const CartPage({Key? key}) : super(key: key);

//   @override
//   _CartPageState createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Row(
//           children: [
//             // Consumer<CartViewModel>(
//             //   builder: (context, counter, child) {
//             //     return Text(counter.count.toString());
//             //   },
//             // ),
//             Consumer<CartViewModel>(
//               builder: (context, counterr, child) {
//                 return Text(counterr.countt.toString());
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //int counter = 0;
    //int counter = sharedPreferences!.getStringList("userCart")!.length - 1;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Consumer<CartViewModel>(
              builder: (context, counter, _) {
                return Text(counter.count.toString());
              },
            ),
            //Text(counter.toString()),
            const Text("se")
          ],
        ),
      ),
    );
  }
}
