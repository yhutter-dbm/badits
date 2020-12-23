import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          child: Text('Dashboard'),
        ),
      ),
    );
  }
}
