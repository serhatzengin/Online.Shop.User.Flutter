import 'package:flutter/material.dart';
import 'package:online_shop_user/global/globaal.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                child: ClipOval(
                  child: Image.network(
                    sharedPreferences!.getString("photoUrl")!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(sharedPreferences!.getString("name")!),
            ],
          ),
          Container(
            child: Column(
              children: [
                const Divider(height: 10),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.black),
                  title: const Text("Profili Düzenle"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.reorder, color: Colors.black),
                  title: const Text("Siparişlerim"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.history, color: Colors.black),
                  title: const Text("Geçmiş"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.search, color: Colors.black),
                  title: const Text("Ara"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.add_location, color: Colors.black),
                  title: const Text("Adres Ekle"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.black),
                  title: const Text("Şifre Güncelle"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.black),
                  title: const Text("Çıkış Yap"),
                  onTap: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
