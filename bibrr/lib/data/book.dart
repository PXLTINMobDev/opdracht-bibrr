class Book {
  String title = '';
  String author = '';
  String image = '';
  String localizedDescription = '';
  int pages = 0;
  String isbn = '';
  String publisher = '';
  String publishedDate = '';


  Book(this.title, this.author, this.image, this.localizedDescription, this.pages, this.isbn, this.publisher, this.publishedDate);

  Book.fromJson(Map<String, dynamic> bookMap) {
    this.title = bookMap['title'] ?? '';

    this.author = (bookMap['authors'] != null && bookMap['authors'] is List)
            ? (bookMap['authors'] as List).join(', ')
            : '';
    this.image = bookMap['imgUrl'] ?? '';
    this.localizedDescription = bookMap['localizedDescription'] ?? 'There is no description available';
    this.pages = bookMap['pages'] ?? 0;
    this.publisher = bookMap['publisher'] ?? '';
    this.publishedDate = bookMap['published'] ?? '';
    
  }
}
