import 'package:bibrr/data/book.dart';
import 'package:bibrr/services/LanguageService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailPageScreen extends StatefulWidget {
  final Book book;
  const BookDetailPageScreen({Key? key, required this.book}) : super(key: key);

  @override
  _BookDetailPageScreenState createState() => _BookDetailPageScreenState();
}

class _BookDetailPageScreenState extends State<BookDetailPageScreen> {
  late Future<String> _translatedDescription;

  @override
  void initState() {
    super.initState();
    _loadTranslatedDescription();
  }

  void _loadTranslatedDescription() {
    final languageService = Provider.of<LanguageService>(context, listen: false);
    String languageCode = languageService.currentLanguageCode;

    setState(() {
      _translatedDescription = widget.book.getTranslatedDescription(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<String>(
          future: _translatedDescription,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text(languageService.getString('translation_error', 'Error translating description.'));
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.book.image.isNotEmpty
                        ? Image.network(widget.book.image)
                        : const Icon(Icons.book, size: 80),
                    const SizedBox(height: 16),
                    Text(
                      widget.book.title,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: languageService.getString('author_label', 'Author: '),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: widget.book.author,
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
                      languageService.getString('description_label', 'Description:'),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.data ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: languageService.getString('pages_label', 'Pages: '),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: '${widget.book.pages}',
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
              );
            }
          },
        ),
      ),
    );
  }
}