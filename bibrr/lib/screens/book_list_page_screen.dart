import 'package:bibrr/data/book.dart';
import 'package:bibrr/data/http_helper.dart';
import 'package:flutter/material.dart';

class Booklistpagescreen extends StatefulWidget {
  const Booklistpagescreen({super.key});

  @override
  State<Booklistpagescreen> createState() => _BooklistpagescreenState();
}

class _BooklistpagescreenState extends State<Booklistpagescreen> {
  List<Book> books = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BibRR'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings-page');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(
                              border:
                                    Border.all(color: Colors.black, width: 1)),
                            margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: ListTile(
                                title: Text(books[index].title),
                                subtitle: Text(books[index].author),
                              ),
                            ));
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getData() async {
    setState(() {
      //isLoading = true;
    });

    HttpHelper helper = HttpHelper();
    List<Book> result = await helper.getBooks();
    setState(() {
      books = result;
      isLoading = false;
    });
  }
}
