import 'package:flutter/material.dart';

class AnasayfaUrunWidget extends StatefulWidget {
  const AnasayfaUrunWidget(
      {super.key,
      required this.baslik,
      required this.resimAdresi,
      required this.tryFiyat,
      required this.indirimOrani});

  final String baslik;
  final String resimAdresi;
  final double tryFiyat;
  final double indirimOrani;

  @override
  State createState() {
    return _AnasayfaUrunWidgetState();
  }
}

/* String baslik = "Klasik Kahve";
String resimAdresi = "assets/classic.jpg";

double tryFiyat = 400;

bool favorideMi = false;

double indirimOrani = 20.0; */

class _AnasayfaUrunWidgetState extends State<AnasayfaUrunWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                widget.resimAdresi,
                width: 250,
                height: 250,
              ),
              const Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.favorite_outline_rounded,
                    shadows: [BoxShadow(blurRadius: 10, color: Colors.black)],
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
          Text(widget.baslik),
          Row(
            children: [
              Text(
                "₺${widget.tryFiyat}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "₺350",
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.red,
                ),
              ),
              Text("${widget.indirimOrani}% indirim"),
            ],
          ),
        ],
      ),
    );
  }
}
