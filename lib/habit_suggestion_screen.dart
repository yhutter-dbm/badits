import 'package:badits/create_habig_dialog.dart';
import 'package:badits/routes.dart';
import 'package:flutter/material.dart';

class HabitSuggestionScreen extends StatelessWidget {
  final List<IconData> _suggestionIcons = [
    Icons.ac_unit,
    Icons.ac_unit_rounded,
    Icons.access_time,
    Icons.access_alarms_rounded,
    Icons.accessible_forward,
    Icons.account_balance,
    Icons.add_a_photo,
    Icons.account_circle_sharp
  ];

  List<Widget> _generateSuggestions(
      BuildContext context, int numberOfSuggestions) {
    return List.generate(numberOfSuggestions, (index) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacementNamed(DASHBOARD_SCREEN_ROUTE);
        },
        child: Card(
            child: ListTile(
          leading: Icon(_suggestionIcons[index]),
          title: Text('Element # ${index + 1}'),
          subtitle: Text('Some suggestion text...'),
        )),
      );
    });
  }

  void _showCreateHabitDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => CreateHabitDialogWidget(),
        barrierDismissible: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showCreateHabitDialog(context);
          },
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: Text('Choose a suggestion'),
          centerTitle: true,
        ),
        body: Container(
          child: GridView.count(
              crossAxisSpacing: 2,
              crossAxisCount: 2,
              children: _generateSuggestions(context, _suggestionIcons.length)),
        ));
  }
}
