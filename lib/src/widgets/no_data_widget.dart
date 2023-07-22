import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {

  //String text;

  const NoDataWidget({Key key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      child: Image.asset('assets/img/novacancy.png'),
    );
  }
}
