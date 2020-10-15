import 'package:badits/screens/dashboard_screen.dart';
import 'package:badits/screens/habit_suggestion_screen.dart';
import 'package:badits/models/routes.dart';
import 'package:badits/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(BaditsApp());

class BaditsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WELCOME_SCREEN_ROUTE,
      routes: {
        WELCOME_SCREEN_ROUTE: (context) => WelcomeScreen(),
        HABIT_SUGGESTION_ROUTE: (context) => HabitSuggestionScreen(),
        DASHBOARD_SCREEN_ROUTE: (context) => DashboardScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
