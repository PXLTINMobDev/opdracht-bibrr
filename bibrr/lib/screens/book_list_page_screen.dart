import 'package:bibrr/data/book.dart';
import 'package:bibrr/data/http_helper.dart';
import 'package:bibrr/screens/book_detail_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Booklistpagescreen extends StatefulWidget {
  const Booklistpagescreen({super.key});

  @override
  State<Booklistpagescreen> createState() => _BooklistpagescreenState();
}

class _BooklistpagescreenState extends State<Booklistpagescreen> {
  List<Book> books = [];
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  Book? selectedBook; 


  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
      return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // horizontaal
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: buildScaffold(body: buildBookList()),
                ),
                selectedBook != null
                    ? Expanded(
                        flex: 1,
                        child: Stack(
                          children: [
                            Bookdetailpagescreen(book: selectedBook!),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    selectedBook = null; 
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            );
          } else {
            // verticaal
            return  buildScaffold(body: buildBookList());
          }
        },
    );
  }
  Widget buildScaffold({required Widget body}) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: body, 
    );
  }

  Widget buildBookList() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildSearchBar(),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (MediaQuery.of(context).size.width > 600) {
                              setState(() {
                                selectedBook = books[index];
                              });
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Bookdetailpagescreen(
                                    book: books[index],
                                  ),
                                ),
                              );
                            }
                          },
                          child: buildBookItem(books[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Padding(
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
              getData(query: _searchController.text);
            },
          ),
        ],
      ),
    );
  }

  Widget buildBookItem(Book book) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color.fromARGB(255, 206, 205, 205),
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            book.image.isNotEmpty
                ? Image.network(
                    book.image,
                    width: 80,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.book, size: 80),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    book.author,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
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
    if (query.isEmpty){
      query = ':title';
    }

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
