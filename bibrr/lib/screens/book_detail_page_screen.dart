import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:bibrr/data/book.dart';

class Bookdetailpagescreen extends StatelessWidget {
  final Book book;
  Bookdetailpagescreen({super.key, required this.book});

  final Map<String, String> _strings = {};

Future<void> _loadStrings() async {
    try {
      final String response = await rootBundle.loadString('assets/strings.json');
      final data = json.decode(response) as Map<String, dynamic>;
      _strings.addAll(data.map((key, value) => MapEntry(key, value.toString())));
    } catch (e) {
      print('Error loading strings: $e'); // Print error for debugging
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadStrings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(book.title),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    book.image.isNotEmpty
                        ? Image.network(book.image)
                        : const Icon(Icons.book, size: 80),
                    const SizedBox(height: 16),
                    Text(
                      book.title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: _strings['author_label'] ?? 'Author: ',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: book.author,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _strings['description_label'] ?? 'Description:',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      book.localizedDescription,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: _strings['pages_label'] ?? 'Pages: ',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: '${book.pages}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}