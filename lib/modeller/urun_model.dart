class UrunModel {
  final String uid;
  final String baslik;
  final String resimAdresi;
  final int tryFiyat;
  final double indirimOrani;
  final double indirimliFiyat;

  const UrunModel({
    required this.uid,
    required this.baslik,
    required this.resimAdresi,
    required this.tryFiyat,
    required this.indirimOrani,
    required this.indirimliFiyat,
  });

  factory UrunModel.fromFirestore(Map map, String uid) {
    return UrunModel(
        uid: uid,
        baslik: map['title'],
        resimAdresi: map['imageUrl'],
        tryFiyat: map['tryPrice'],
        indirimOrani: map['discountRatio'],
        indirimliFiyat: map['discountPrice']);
  }
}
