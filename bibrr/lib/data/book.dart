class Book {
  String title = '';
  String author = '';
  String image = '';

  Book(this.title, this.author, this.image);

  Book.fromJson(Map<String, dynamic> bookMap) {
    this.title = bookMap['title'] ?? '';

    this.author = (bookMap['authors'] != null && bookMap['authors'] is List)
            ? (bookMap['authors'] as List).join(', ')
            : '';
    this.image = bookMap['imgUrl'] ?? '';
  }
}
