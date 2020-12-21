import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddHabitButtonWidget extends StatelessWidget {
  final Function onPressed;

  const AddHabitButtonWidget({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: this.onPressed,
        child: Container(
          height: 60,
          width: 60,
          decoration:
              BoxDecoration(color: Colors.black, shape: BoxShape.circle),
          child: SvgPicture.asset('assets/icons/plus_button.svg',
              color: Colors.white),
        ));
  }
}
