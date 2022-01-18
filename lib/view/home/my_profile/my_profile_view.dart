import 'package:flutter/material.dart';
import 'package:online_shop_user/global/global.dart';
import 'package:online_shop_user/view/authentication/auth_screen/auth_screen.dart';
import 'package:online_shop_user/view/home/adress/address_view.dart';

class MyProfileView extends StatefulWidget {
  const MyProfileView({Key? key}) : super(key: key);

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                      child: Image.network(
                        sharedPreferences!.getString("photoUrl")!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    sharedPreferences!.getString("name")!,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: ListView(
                children: [
                  const Divider(height: 10),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.person, color: Colors.black),
                      title: const Text("Profili Düzenle"),
                      onTap: () {},
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.shop, color: Colors.black),
                      title: const Text("Siparişlerim"),
                      onTap: () {},
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.history, color: Colors.black),
                      title: const Text("Geçmiş"),
                      onTap: () {},
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.search, color: Colors.black),
                      title: const Text("Ara"),
                      onTap: () {},
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading:
                          const Icon(Icons.add_location, color: Colors.black),
                      title: const Text("Adreslerim"),
                      onTap: () {
                        Route route = MaterialPageRoute(
                            builder: (c) => const AddressPage());
                        Navigator.push(context, route);
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.password, color: Colors.black),
                      title: const Text("Şifre Güncelle"),
                      onTap: () {},
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading:
                          const Icon(Icons.exit_to_app, color: Colors.black),
                      title: const Text("Çıkış Yap"),
                      onTap: () {
                        firebaseAuth.signOut().whenComplete(() =>
                            Navigator.push((context),
                                MaterialPageRoute(builder: (c) => AuthPage())));
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
