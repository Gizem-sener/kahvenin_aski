import 'package:flutter/material.dart';
import 'package:kahvenin_aski/sayfalar/anasayfa.dart';
import 'package:kahvenin_aski/sayfalar/giris_sayfasi.dart';
import 'package:firebase_auth/firebase_auth.dart';

class YuklenmeSayfasi extends StatelessWidget {
  const YuklenmeSayfasi({super.key});

  final girisYapildi = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (_, snapshot) {
          final girisYapildi = snapshot.hasData && snapshot.data != null;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: girisYapildi ? const Anasayfa() : const GirisSayfasi(),
          );
        });
  }
}
