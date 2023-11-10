import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network('https://www.flashimportados.com.py/assets/img/loading-small.gif', width: 100, height: 100),
      )
    );
  }
}