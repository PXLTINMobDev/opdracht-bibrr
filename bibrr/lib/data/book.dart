class Book {
  String title = '';
  String author = '';

  Book(this.title, this.author);

  Book.fromJson(Map<String, dynamic> bookMap) {
    this.title = bookMap['title'] ?? '';
    this.author = bookMap['authors'][0]['name'] ?? '';

    
  }
}
