import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kahvenin_aski/sayfalar/bize_ulasin.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.indigo,
              image: DecorationImage(
                  image: AssetImage('assets/profil.jpg'), fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(255, 25, 0, 25),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios_rounded,
                    color: Colors.white),
                onPressed: () {},
              ),
            ),
          ),
          ListTile(
            /* onTap:  () {
            Navigator.push(context, MaterialPageRoute(
              builder: ((context) => Urunler())));
          }, */
            onTap: () {},
            title: const Text("Ürünler"),
            leading: const Icon(Icons.category_rounded),
          ),
          ListTile(
            onTap: () {},
            title: const Text("Siparişlerim"),
            leading: const Icon(Icons.shopping_bag_rounded),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.favorite_rounded),
            title: const Text("Favorilerim"),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const BizeUlasin())));
            },
            title: const Text("Bize Ulaşın"),
            leading: const Icon(Icons.mail_rounded),
          ),
          ListTile(
            onTap: () {},
            title: const Text("Ayarlar"),
            leading: const Icon(Icons.settings_rounded),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Scaffold.of(context).closeDrawer();
            },
            title: const Text("Çıkış Yap"),
            leading: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
    );
  }
}
