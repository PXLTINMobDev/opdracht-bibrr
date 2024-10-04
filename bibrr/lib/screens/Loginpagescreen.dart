
import 'package:flutter/material.dart';

class Loginpagescreen extends StatelessWidget {
  const Loginpagescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/book-list');
            },
          ),
        ],
      ),
    );
}
}