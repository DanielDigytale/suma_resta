import 'package:flutter/material.dart';
import 'homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App to sum and rest',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(
          title: 'Sumar y Restar fácil'
      ),
    );
  }
}

