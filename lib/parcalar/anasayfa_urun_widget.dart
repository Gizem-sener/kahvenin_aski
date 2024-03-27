import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kahvenin_aski/modeller/urun_model.dart';

class AnasayfaUrunWidget extends StatefulWidget {
  const AnasayfaUrunWidget({super.key, required this.urun});

  final UrunModel urun;

  @override
  State createState() {
    return _AnasayfaUrunWidgetState();
  }
}

class _AnasayfaUrunWidgetState extends State<AnasayfaUrunWidget> {
  bool _favorideMi = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    return SizedBox(
      child: Card(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  widget.urun.resimAdresi,
                  width: 250,
                  height: 250,
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          _favorideMi = !_favorideMi;
                          setState(() {});
                        },
                        icon: _favorideMi
                            ? const Icon(
                                Icons.favorite_rounded,
                                size: 30,
                                color: Colors.red,
                                shadows: [
                                  BoxShadow(blurRadius: 15, color: Colors.black)
                                ],
                              )
                            : const Icon(
                                Icons.favorite_outline_rounded,
                                size: 30,
                                color: Colors.red,
                                shadows: [
                                  BoxShadow(blurRadius: 10, color: Colors.black)
                                ],
                              )),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: StreamBuilder(
                          stream: userDoc.snapshots(),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              final List cartArray =
                                  snapshot.data!['cart'] ?? [];
                              final inCart =
                                  cartArray.contains(widget.urun.uid);

                              return IconButton(
                                onPressed: () {
                                  if (inCart) {
                                    userDoc.update({
                                      'cart': FieldValue.arrayRemove(
                                          [widget.urun.uid])
                                    });
                                  } else {
                                    userDoc.update({
                                      'cart': FieldValue.arrayUnion(
                                          [widget.urun.uid])
                                    });
                                  }
                                },
                                icon: inCart
                                    ? const Icon(
                                        Icons.shopping_bag_rounded,
                                        size: 30,
                                        color: Color.fromARGB(255, 59, 26, 24),
                                      )
                                    : const Icon(Icons.shopping_bag_outlined,
                                        size: 30,
                                        color: Color.fromARGB(255, 59, 26, 24)),
                              );
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          })),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.urun.baslik,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  "₺${widget.urun.indirimliFiyat}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "₺${widget.urun.tryFiyat}",
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 16),
                Text("% ${widget.urun.indirimOrani} indirim"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
