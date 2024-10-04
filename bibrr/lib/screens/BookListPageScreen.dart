import 'package:flutter/material.dart';

class Booklistpagescreen extends StatelessWidget {
  const Booklistpagescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BibRR'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Text('This is the Book List Page'),
      ),
    );
  }
}
