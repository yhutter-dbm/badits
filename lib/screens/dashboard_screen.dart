import 'package:badits/screens/habits_overview_screen.dart';
import 'package:badits/screens/habits_to_complete_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.check)),
              Tab(icon: Icon(Icons.data_usage))
            ],
          ),
        ),
        body: TabBarView(
          children: [HabitsToComplete(), HabitsOverViewScreen()],
        ),
      ),
    );
  }
}
