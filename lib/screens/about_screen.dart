import 'package:badits/models/routes.dart';
import 'package:badits/widgets/cancel_button_widget.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Badits',
                style: TextStyle(
                    fontFamily: 'ObibokBold',
                    color: Colors.black,
                    fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  'About',
                  style: TextStyle(
                      fontFamily: 'ObibokRegular',
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset('assets/images/coffee.gif')),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Concept & Code:\r\nYannick H., Loris H.\r\n\r\nIllustrations:\r\nOpen Doodles\r\n\r\nFonts:\r\nObibok & Plain',
                  style: TextStyle(
                      fontFamily: 'ObibokRegular',
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Spacer(),
              CancelButtonWidget(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(DASHBOARD_SCREEN_ROUTE);
                },
              )
            ],
          )),
    );
  }
}
