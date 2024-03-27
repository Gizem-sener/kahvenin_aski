import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahvenin_aski/modeller/urun_model.dart';
import 'package:kahvenin_aski/parcalar/anasayfa_urun_widget.dart';
import 'package:kahvenin_aski/parcalar/app_drawer.dart';
import 'package:kahvenin_aski/parcalar/category_widget.dart';
import 'package:flutter/gestures.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  //Kalan süre değişkeni
  late Duration _timeUntilTarget;
  //pageView controller değişkeni
  final PageController controller = PageController(initialPage: 0);
  //pageView in bulunduğu sayfayı kontol için değişken
  int currentPage = 0;
  //slider noktaları
  late Color dot1 = const Color.fromRGBO(29, 78, 216, 1);
  late Color dot2 = Colors.grey;
  late Color dot3 = Colors.grey;
  late Color dot4 = Colors.grey;
  late Color dot5 = Colors.grey;
  //Slider otomatik kayması için sayaç
  int sayac = 0;

  @override
  void initState() {
    super.initState();

    //Hedef an
    DateTime targetDate = DateTime(2024, 5, 30, 11);

/*
    //Tekrar dedin sayaç(zamana bağlı işlemler için)
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() async {
        int nextPage = (controller.page?.round() ?? 0) + 1;
        if (nextPage > 4) {
          nextPage = 0;
        }
        if (sayac == 8) {
          controller.animateToPage(nextPage,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
          sayac = 0;
        }
        sayac++;
        _timeUntilTarget = targetDate.difference(DateTime.now());
      });
    });*/

    //Hedef ana kalan sürenin hesaplandığı yer
    _timeUntilTarget = targetDate.difference(DateTime.now());

    // Sayfa değiştiği andaki işlemler
    controller.addListener(() {
      setState(() {
        currentPage = controller.page?.round() ?? 0;
        switch (currentPage) {
          case 0:
            dot1 = const Color.fromRGBO(29, 78, 216, 1);
            dot2 = Colors.grey;
            dot3 = Colors.grey;
            dot4 = Colors.grey;
            dot5 = Colors.grey;
          case 1:
            dot1 = Colors.grey;
            dot2 = const Color.fromRGBO(29, 78, 216, 1);
            dot3 = Colors.grey;
            dot4 = Colors.grey;
            dot5 = Colors.grey;
          case 2:
            dot1 = Colors.grey;
            dot2 = Colors.grey;
            dot3 = const Color.fromRGBO(29, 78, 216, 1);
            dot4 = Colors.grey;
            dot5 = Colors.grey;
          case 3:
            dot1 = Colors.grey;
            dot2 = Colors.grey;
            dot3 = Colors.grey;
            dot4 = const Color.fromRGBO(29, 78, 216, 1);
            dot5 = Colors.grey;
          case 4:
            dot1 = Colors.grey;
            dot2 = Colors.grey;
            dot3 = Colors.grey;
            dot4 = Colors.grey;
            dot5 = const Color.fromRGBO(29, 78, 216, 1);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kahvenin Aşkı',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.left,
        ),
        backgroundColor: Colors.redAccent.shade700,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            //Arama Butonu
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Aramak istediğiniz ürünü giriniz...",
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide:
                          BorderSide(color: Color(0xFFD1D5DB), width: 1)),
                ),
              ),
            ),
            //Kategoriler
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  const Text(
                    "Kategoriler",
                    style: TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 20,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      height: 0.11,
                      letterSpacing: 0.07,
                    ),
                  ),
                  const Spacer(),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Tümünü Gör ->',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 117, 117, 117),
                            fontFamily: 'Inter',
                            fontSize: 16),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('Tümünü Gör');
                          })
                  ])),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            //Kategori Resimler (Kaydırma)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder(
                future:
                    FirebaseFirestore.instance.collection('categories').get(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    final categoryList =
                        snapshot.data!.docs.map((e) => e.data()).toList();
                    return Row(
                      children: [
                        const SizedBox(width: 6),
                        for (final data in categoryList)
                          CategoryWidget(
                            title: data['title'],
                            imageUrl: data['imageUrl'],
                          ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            //Slider
            SizedBox(
              width: 550,
              height: 300,
              child: PageView(
                controller: controller,
                children: <Widget>[
                  Center(
                    child: Image.asset("assets/Slider1.jpg"),
                  ),
                  Center(
                    child: Image.asset("assets/Slider2.jpg"),
                  ),
                  Center(
                    child: Image.asset("assets/Slider3.jpg"),
                  ),
                  Center(
                    child: Image.asset("assets/Slider4.jpg"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.circle,
                      size: 6,
                      color: dot1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.circle,
                      size: 6,
                      color: dot2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.circle,
                      size: 6,
                      color: dot3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.circle,
                      size: 6,
                      color: dot4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.circle,
                      size: 6,
                      color: dot5,
                    ),
                  ),
                ],
              ),
            ),
            //Deal of the day + Sayaç + Özel indirimler
            Container(
              color: const Color.fromRGBO(246, 246, 246, 1),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      child: Row(
                        children: [
                          const Text(
                            "Günün Fırsatları",
                            style: TextStyle(
                              color: Color.fromARGB(255, 151, 0, 38),
                              fontSize: 20,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                              height: 0.11,
                              letterSpacing: 0.07,
                            ),
                          ),
                          const Spacer(),
                          RichText(
                              text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: 'Tümünü Gör ->',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 117, 117, 117),
                                    fontFamily: 'Inter',
                                    fontSize: 16),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('Tümünü Gör');
                                  })
                          ])),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 2),
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromARGB(255, 239, 68, 68),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "${_timeUntilTarget.inDays} DAY ${_timeUntilTarget.inHours % 24} HRS ${_timeUntilTarget.inMinutes % 60} MIN ${_timeUntilTarget.inSeconds % 60} SEC",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromRGBO(255, 255, 255, 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                          "assets/kapsul.jpg",
                                          height: 100,
                                          width: 100,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Ganoderma Kapsül",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color.fromARGB(
                                                255, 239, 68, 68),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Text(
                                              "Üyelik Avantajları",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      children: [
                                        Image.asset(
                                          "assets/misty.jpg",
                                          height: 100,
                                          width: 100,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Ganoderma Yüz Misti",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color.fromARGB(
                                                255, 239, 68, 68),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Text(
                                              "%40'a Varan İndirimler",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1)),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset(
                                            "assets/classic.jpg",
                                            height: 100,
                                            width: 100,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Text("Klasik Kahve",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: const Color.fromARGB(
                                                  255, 239, 68, 68),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Text(
                                                "Reishi Mantarı Mucizesi",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        children: [
                                          Image.asset("assets/supreno.jpg",
                                              height: 100, width: 100),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Text(
                                              "Enerji verici kahve",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: const Color.fromARGB(
                                                  255, 239, 68, 68),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Text(
                                                "40-60% İndirim",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1)),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // İçecek Serisi
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    "İçecek Serisi",
                    style: TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 20,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      height: 0.11,
                      letterSpacing: 0.07,
                    ),
                  ),
                  const Spacer(),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Tümünü Gör ->',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 117, 117, 117),
                            fontFamily: 'Inter',
                            fontSize: 16),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('Tümünü Gör');
                          })
                  ])),
                ],
              ),
            ),
            FutureBuilder(
                future: FirebaseFirestore.instance.collection('products').get(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    final urunler = snapshot.data!.docs
                        .map((e) => UrunModel.fromFirestore(e.data(), e.id));
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (final urun in urunler)
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: AnasayfaUrunWidget(urun: urun),
                            ),
                        ],
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
            const SizedBox(height: 20),
            // Size Özel
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    "Size Özel",
                    style: TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 20,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      height: 0.11,
                      letterSpacing: 0.07,
                    ),
                  ),
                  const Spacer(),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Tümünü Gör ->',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 117, 117, 117),
                            fontFamily: 'Inter',
                            fontSize: 16),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('Tümünü Gör');
                          })
                  ])),
                ],
              ),
            ),
            FutureBuilder(
              future: FirebaseFirestore.instance.collection('foryou').get(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  final urunler = snapshot.data!.docs
                      .map((e) => UrunModel.fromFirestore(e.data(), e.id));
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final urun in urunler)
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: AnasayfaUrunWidget(urun: urun),
                          ),
                      ],
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        selectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Anasayfa",
            backgroundColor: Color.fromARGB(50, 25, 155, 120),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: "Kategoriler",
            backgroundColor: Color.fromARGB(50, 25, 155, 120),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits),
            label: "Siparişlerim",
            backgroundColor: Color.fromARGB(50, 25, 155, 120),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            label: "Profilim",
            backgroundColor: Color.fromARGB(50, 25, 155, 120),
          ),
        ],
        selectedLabelStyle: const TextStyle(color: Colors.black),
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
