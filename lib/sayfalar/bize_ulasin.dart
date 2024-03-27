import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';

class BizeUlasin extends StatelessWidget {
  const BizeUlasin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 179, 205),
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
      backgroundColor: const Color.fromARGB(255, 255, 179, 205),
      body: ContactUs(
        logo: const AssetImage('assets/icon.png'),
        email: 'nevinsener75@gmail.com',
        companyName: 'Kahvenin Aşkı',
        phoneNumber: '+905382913553',
        dividerThickness: 2,
        website: 'kahveninaski.web.app',
        tagLine: 'Gano Excel Bağımsız Distribütörü',
        instagram: 'kahveninaski',
        textColor: const Color.fromARGB(255, 255, 255, 255),
        cardColor: const Color.fromARGB(232, 218, 76, 76),
        companyColor: const Color.fromARGB(255, 151, 0, 38),
        taglineColor: const Color.fromARGB(255, 207, 22, 68),
        avatarRadius: 98,
        companyFont: 'Inter',
        emailText: 'Email',
      ),
    );
  }
}
