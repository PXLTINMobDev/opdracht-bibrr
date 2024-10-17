// import 'package:bibrr/screens/BookListPageScreen.dart';
//import 'package:bibrr/screens/book_detail_page_screen.dart';
import 'package:bibrr/pages/AuthPage.dart';
import 'package:bibrr/screens/book_list_page_screen.dart';
import 'package:bibrr/screens/login_page_screen.dart';
import 'package:bibrr/screens/setting_page_screen.dart';
//import 'package:bibrr/screens/Loginpagescreen.dart';
// import 'package:bibrr/screens/Settingpagescreen.dart';
import 'package:flutter/material.dart';
import 'package:bibrr/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: const AuthPage(),
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
        '/login': (context) => Loginpagescreen(),
        '/book-detail': (context) => const Booklistpagescreen(),
        '/settings-page': (context) => const Settingpagescreen(),
      },

      initialRoute: '/',
      
    );
  }
}
