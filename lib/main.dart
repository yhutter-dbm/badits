import 'package:badits/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(BaditsApp());

class BaditsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
