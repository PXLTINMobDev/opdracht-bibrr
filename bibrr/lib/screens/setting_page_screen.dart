import 'package:flutter/material.dart';

class Settingpagescreen extends StatelessWidget {
  const Settingpagescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.red,
        ),
      )
    );
  }
}