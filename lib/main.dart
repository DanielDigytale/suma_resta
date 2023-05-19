import 'package:flutter/material.dart';
import 'homePage.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App of math ops easy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(
          title: 'App de + - x fácil'
      ),
    );
  }
}

