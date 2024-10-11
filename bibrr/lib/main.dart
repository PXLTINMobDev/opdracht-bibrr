// import 'package:bibrr/screens/BookListPageScreen.dart';
//import 'package:bibrr/screens/book_detail_page_screen.dart';
import 'package:bibrr/screens/book_list_page_screen.dart';
import 'package:bibrr/screens/login_page_screen.dart';
import 'package:bibrr/screens/setting_page_screen.dart';
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
      theme: ThemeData(
        primaryColor: Color(0xFFAEDFF7),
        scaffoldBackgroundColor: Color.fromARGB(235, 255, 255, 255), 
        appBarTheme: AppBarTheme(
          color: Color(0xFFAEDFF7), 
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFFAEDFF7),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFAEDFF7), 
        ),
        iconTheme: IconThemeData(
          color: Colors.blueGrey, 
        ),

      ),
      routes: {
        '/book-list': (context) => const Booklistpagescreen(),
        '/login': (context) => const Loginpagescreen(),
        '/book-detail': (context) => const Booklistpagescreen(),
        '/settings-page': (context) => const Settingpagescreen(),
      },

      initialRoute: '/login',
    );
  }
}
