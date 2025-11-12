import 'package:flutter/material.dart';

class Basic extends StatelessWidget {
  const Basic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "First practice",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 10,
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: const Text(
          "Hello! Welcome to the first practice of Flutter",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Lucida Console',
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 120, 170, 210),
          ),
        ),
      ),
    );
  }
}
