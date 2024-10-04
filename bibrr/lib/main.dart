// import 'package:bibrr/screens/BookListPageScreen.dart';
import 'package:bibrr/screens/BookDetailPageScreen.dart';
//import 'package:bibrr/screens/Loginpagescreen.dart';
// import 'package:bibrr/screens/Settingpagescreen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      routes: {
        '/book-list': (context) => Bookdetailpagescreen(),
        //'/login': (context) => Loginpagescreen(),
        
        // '/book-detail': (context) => Booklistpagescreen(),
        // '/settings-page': (context) => Settingpagescreen(),
      },

      initialRoute: '/book-list',
    );
  }
}
