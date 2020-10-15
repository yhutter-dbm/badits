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

  List<Widget> _generateSuggestions(int numberOfSuggestions) {
    return List.generate(numberOfSuggestions, (index) {
      return Card(
          child: ListTile(
        leading: Icon(_suggestionIcons[index]),
        title: Text('Element # ${index + 1}'),
        subtitle: Text('Some suggestion text...'),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: null,
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
              children: _generateSuggestions(_suggestionIcons.length)),
        ));
  }
}
