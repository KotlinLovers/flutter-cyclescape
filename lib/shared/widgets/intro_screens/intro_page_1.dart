import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget{
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.cyan,
      child: Center(
        child: Text('Intro Page 1'),
      ),
    );
  }
}