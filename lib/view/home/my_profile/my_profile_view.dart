import 'package:flutter/material.dart';
import 'package:online_shop_user/component/custom_button.dart';
import 'package:online_shop_user/global/globaal.dart';
import 'package:online_shop_user/view/authentication/auth_screen/auth_screen.dart';


class MyProfileView extends StatefulWidget {
  const MyProfileView({Key? key}) : super(key: key);

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  List stocksList = [
    CompanyStocks(name: "Facebook", price: 339.1),
    CompanyStocks(name: "A10 NETWORKS INC.", price: 10.34),
    CompanyStocks(name: "Intel Corp", price: 56.96),
    CompanyStocks(name: "HP Inc", price: 32.43),
    CompanyStocks(name: "Advanced Micro Devices Inc.", price: 77.44),
    CompanyStocks(name: "Apple Inc", price: 133.98),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemCount: stocksList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          stocksList[index].name,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        leading: CircleAvatar(
                          child: Text(
                            stocksList[index].name[0],
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ),
                  );
                },
              ),
            ),
            CustomButton(
              buttonText: "Çıkış Yap",
              pressed: () {
                firebaseAuth.signOut().whenComplete(() => Navigator.push(
                    (context), MaterialPageRoute(builder: (c) => AuthPage())));
              },
            )
          ],
        ),
      ),
    );
  }
}

class CompanyStocks {
  String name;
  double price;
  CompanyStocks({
    required this.name,
    required this.price,
  });
}
