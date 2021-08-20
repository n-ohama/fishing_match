import 'package:fishing_match/widgets/picker_widget.dart';
import 'package:flutter/material.dart';

class Debag extends StatelessWidget {
  static const routeName = '/debag';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 64),
        child: Center(child: PickerWidget()),
      ),
    );
  }
}
