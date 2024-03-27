import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kahvenin_aski/firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:kahvenin_aski/sayfalar/yuklenme_sayfasi.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterNativeSplash.remove();
  runApp(const YuklenmeSayfasi());
}
