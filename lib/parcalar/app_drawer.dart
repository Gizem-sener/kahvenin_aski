import 'package:flutter/material.dart';

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
          const ListTile(
            /* onTap:  () {
            Navigator.push(context, MaterialPageRoute(
              builder: ((context) => Urunler())));
          }, */
            title: Text("Ürünler"),
            leading: Icon(Icons.category_rounded),
          ),
          const ListTile(
            /* onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: ((context) => Siparisler())));
              }, */
            title: Text("Siparişlerim"),
            leading: Icon(Icons.shopping_bag_rounded),
          ),
          const ListTile(
            /* onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: ((context) => Favoriler())));
              },  */
            leading: Icon(Icons.favorite_rounded),
            title: Text("Favorilerim"),
          ),
          const ListTile(
            /*  onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: ((context) => Adresler())));
              }, */
            title: Text("Bize Ulaşın"),
            leading: Icon(Icons.mail_rounded),
          ),
          const ListTile(
            /*  onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: ((context) => Ayarlar())));
              }, */
            title: Text("Ayarlar"),
            leading: Icon(Icons.settings_rounded),
          ),
          const ListTile(
            /*  onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: ((context) => CikisYap())));
              }, */
            title: Text("Çıkış Yap"),
            leading: Icon(Icons.logout_rounded),
          ),
        ],
      ),
    );
  }
}
