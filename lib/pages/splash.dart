import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xambot/pages/home.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Home()),
      );
    });
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/home_bg.png"), fit: BoxFit.cover),
        ),
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Colors.blueGrey, Colors.grey, Colors.blueGrey],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //   ),
        // ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage("images/logo.png"),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Xam AI Bot",
                style: GoogleFonts.pacifico(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 64),
                child: LinearProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
