import 'package:bibrr/data/book.dart';
import 'package:bibrr/data/http_helper.dart';
import 'package:bibrr/screens/book_detail_page_screen.dart';
import 'package:flutter/material.dart';

class Booklistpagescreen extends StatefulWidget {
  const Booklistpagescreen({super.key});

  @override
  State<Booklistpagescreen> createState() => _BooklistpagescreenState();
}

class _BooklistpagescreenState extends State<Booklistpagescreen> {
  List<Book> books = [];
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for a book title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      // Initiates a search based on the query entered
                      getData(query: _searchController.text);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => Bookdetailpagescreen(book: books[index])),
                              );
                          },
                        
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 206, 205, 205),
                                  width: 1),
                              bottom: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 206, 205, 205),
                                  width: 1),
                              left: BorderSide(
                                  color: Colors.transparent,
                                  width: 1), // Transparent left border
                              right: BorderSide(
                                  color: Colors.transparent, width: 1),
                            ),
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 15),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0), // Add Padding for consistency
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                books[index].image.isNotEmpty
                                    ? Image.network(
                                        books[index].image,
                                        width: 80,
                                        height: 100,
                                        fit: BoxFit.cover, // Make image fill its space
                                      )
                                    : const Icon(Icons.book, size: 80),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        books[index].title,
                                        style: const TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        books[index].author,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getData({String query = ''}) async {
    setState(() {
      isLoading = true;
    });

    HttpHelper helper = HttpHelper();
    //List<Book> result = await helper.getBooks();
    List<Book> result = await helper.getBooks(query);
    //List<Book> result = await helper.getBooks('/lord of the rings');

    setState(() {
      books = result;
      isLoading = false;
    });
  }
}
