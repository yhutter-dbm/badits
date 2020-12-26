import 'package:badits/screens/about_screen.dart';
import 'package:badits/screens/create_habit_screen.dart';
import 'package:badits/screens/dashboard_screen.dart';
import 'package:badits/screens/habit_suggestion_screen.dart';
import 'package:badits/models/routes.dart';
import 'package:badits/screens/welcome_screen.dart';
import 'package:badits/services/service_locator.dart';
import 'package:flutter/material.dart';

void main() {
  setupStorageService();
  runApp(BaditsApp());
}

class BaditsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WELCOME_SCREEN_ROUTE,
      routes: {
        WELCOME_SCREEN_ROUTE: (context) => WelcomeScreen(),
        HABIT_SUGGESTION_ROUTE: (context) => HabitSuggestionScreen(),
        DASHBOARD_SCREEN_ROUTE: (context) => DashboardScreen(),
        CREATE_HABIT_ROUTE: (context) => CreateHabitScreen(),
        ABOUT_ROUTE: (context) => AboutScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
    );
  }
}
