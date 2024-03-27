import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kahvenin_aski/sayfalar/kayit_sayfasi.dart';

class GirisSayfasi extends StatefulWidget {
  const GirisSayfasi({super.key});

  @override
  State<GirisSayfasi> createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  var _yukleniyor = false;
  var _hataMesaji = "";
  var _email = "";
  var _sifre = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Giriş Sayfası",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromARGB(255, 116, 17, 50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_hataMesaji.isNotEmpty)
              Text(
                "Bir Hata Oluştu: $_hataMesaji",
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            SizedBox(
                height: 100,
                width: 100,
                child: Image.asset("assets/kahve.png")),
            const Text(
              "Size özel ayrıcalıklardan yararlanın!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 25,
                color: Color.fromARGB(255, 71, 13, 13),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: "Email Adresini Gir",
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _email = value;
                debugPrint(value);
                if (_hataMesaji.isNotEmpty) {
                  _hataMesaji = "";
                  setState(() {});
                }
              },
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: const InputDecoration(
                hintText: "Şifreni Gir",
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onChanged: (value) {
                _sifre = value;
                debugPrint(value);

                if (_hataMesaji.isNotEmpty) {
                  _hataMesaji = "";
                  setState(() {});
                }
              },
            ),
            const SizedBox(height: 26),
            if (_yukleniyor)
              const CircularProgressIndicator()
            else
              TextButton(
                onPressed: () {
                  final regexExp = RegExp(
                      r"^[A-Za-z0-9._+\-\']+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$");
                  final isValid = _email.isNotEmpty && _sifre.length > 5;

                  if (isValid) {
                    _yukleniyor = true;
                    setState(() {});
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                      email: _email,
                      password: _sifre,
                    )
                        .catchError(
                      (hataMesaji) {
                        _hataMesaji = hataMesaji.toString();
                        _yukleniyor = false;
                        setState(() {});
                      },
                    );
                  } else {
                    _hataMesaji = "Email Adresi ve şifre boş geçilemez";
                    setState(() {});
                  }
                },
                child: const Text(
                  "Giriş Yap",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            const Divider(height: 64),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return const KayitSayfasi();
                    }),
                  );
                },
                child: const Text(
                  "Kayıt Ol",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
