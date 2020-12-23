import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CancelButtonWidget extends StatelessWidget {
  final Function onPressed;

  const CancelButtonWidget({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: this.onPressed,
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(width: 3.0, color: Colors.black)),
          child: SvgPicture.asset('assets/icons/cross_button.svg'),
        ));
  }
}
