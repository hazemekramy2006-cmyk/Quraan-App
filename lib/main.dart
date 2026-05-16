import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quraanapp/Screens/HomePage.dart';

void main() {
  runApp(Quran());
}

class Quran extends StatelessWidget {
  Quran({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
