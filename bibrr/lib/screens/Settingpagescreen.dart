import 'package:flutter/material.dart';

class Settingpagescreen extends StatelessWidget {
  const Settingpagescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.red,
        ),
      )
    );
  }
}