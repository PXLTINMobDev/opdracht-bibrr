import 'package:flutter/material.dart';
import 'package:bibrr/data/book.dart';

class Bookdetailpagescreen extends StatelessWidget {
  final Book book;
  const Bookdetailpagescreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
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
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              RichText(text: TextSpan(children: [
                TextSpan(
                  text: 'Author: ',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold, 
                    color: Colors.black
                  ),
                  
                ),
                TextSpan(
                    text: '${book.author}',
                    style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal, 
                     color: Colors.black
                  ),
                  )
              ])),
              const SizedBox(height: 8),
              Text(
                'Description:',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '${book.localizedDescription}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              RichText(text: TextSpan(children: [
                TextSpan(
                  text: 'Pages: ',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold, 
                    color: Colors.black
                  ),
                  
                ),
                TextSpan(
                    text: '${book.pages}',
                    style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal, 
                     color: Colors.black
                  ),
                  )
              ]))
                        
            ],
          ),
        ),
      ),
    );
  }
}