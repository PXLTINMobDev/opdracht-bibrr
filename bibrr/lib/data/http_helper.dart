
import 'package:bibrr/data/book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HttpHelper {
  //final String authority = 'library-api.postmanlabs.com';
  //final String authority = 'gutendex.com';
  final String authority = 'api.algobook.info';
  Future<List<Book>> getBooks(String title) async {
    //var url = Uri.https(authority, '/books');
    var url = Uri.https(authority, '/v1/ebooks/title/$title');
    http.Response result = await http.get(url);
    List<dynamic> data = json.decode(result.body);
    //Map<String, dynamic> data = json.decode(result.body);
    //List<dynamic> bookList = data['results'];
    List<Book> books = data.map((book) => Book.fromJson(book)).toList();
    return books;
  }
}
