import 'package:flutter/material.dart';
import 'package:kahvenin_aski/parcalar/app_drawer.dart';
/*  veriler(harfler, sayılar vs) ve işlemler; belirli bir dizide işlemek
 işlemler ikiye ayrılıyor: gerçekleştikten sonra ürün çıkartan;
gerçekleştiktem sonra herhangi bir şey çıkartmayan */

//fonksiyon tanımlamak

void main() {
  runApp(const Anasayfa());
}

class Anasayfa extends StatelessWidget {
  const Anasayfa({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDebug = false;

    return MaterialApp(
      debugShowCheckedModeBanner: isDebug,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: const Text(
            "Kahvenin Aşkı",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Aradığınız ürünü yazınız...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: Color(0xFFD1D5DB),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    "Kategoriler",
                    style: TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0.11,
                      letterSpacing: 0.07,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Tümünü Gör ->",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0.12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < 10; i++)
                    Column(
                      children: [
                        if (i % 2 == 0)
                          Image.asset(
                            'assets/kahve.png',
                            height: 50,
                            width: 50,
                          )
                        else
                          Image.asset(
                            'assets/cilt.png',
                            height: 50,
                            width: 50,
                          ),
                        Text(i % 2 == 0 ? "Kahve" : "Cilt Bakımı"),
                      ],
                    ),
                ],
              ),
            )
          ],
        ),
        drawer: const AppDrawer(),
      ),
    );
  }
}
