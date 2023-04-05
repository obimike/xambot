import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xambot/widget/model_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "XamBot",
          style: GoogleFonts.poppins(fontSize: 20),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: const DecorationImage(
                image: AssetImage("images/logo.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        centerTitle: true,
        primary: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.handyman_outlined),
          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            ModelList(label: "gpt-4"),
            ModelList(label: "gpt-3.5-turbo"),
            ModelList(label: "text-davinci-003"),
            ModelList(label: "code-davinci-002"),
          ],
        ),
      )),
    );
  }
}
