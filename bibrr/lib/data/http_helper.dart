
import 'package:bibrr/data/book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HttpHelper {
  //final String authority = 'library-api.postmanlabs.com';
  final String authority = 'gutendex.com';

  Future<List<Book>> getBooks() async {
    var url = Uri.https(authority, '/books');
    http.Response result = await http.get(url);
    Map<String, dynamic> data = json.decode(result.body);
    List<dynamic> bookList = data['results'];
    List<Book> books = bookList.map((book) => Book.fromJson(book)).toList();
    return books;
  }
}
