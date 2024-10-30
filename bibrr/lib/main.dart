import 'package:bibrr/pages/auth_page.dart';
import 'package:bibrr/screens/book_list_page_screen.dart';
import 'package:bibrr/screens/login_page_screen.dart';
import 'package:bibrr/screens/setting_page_screen.dart';
import 'package:bibrr/services/LanguageService.dart';
import 'package:flutter/material.dart';
import 'package:bibrr/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final languageService = LanguageService();
  await languageService.loadLanguage();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      ChangeNotifierProvider(
        create: (_) => languageService,
        child: MyApp(),
      ),
    );
  }

class MyApp extends StatelessWidget {

  //const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: const AuthPage(),
      theme: ThemeData(
        primaryColor: const Color(0xFFAEDFF7),
        scaffoldBackgroundColor: const Color.fromARGB(235, 255, 255, 255), 
        appBarTheme: const AppBarTheme(
          color: Color(0xFFAEDFF7), 
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFFAEDFF7),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFAEDFF7), 
        ),
        iconTheme: const IconThemeData(
          color: Colors.blueGrey, 
        ),

      ),
      routes: {
        '/book-list': (context) => const Booklistpagescreen(),
        '/login': (context) => LoginPageScreen(),
        '/book-detail': (context) => const Booklistpagescreen(),
        '/settings-page': (context) => const Settingpagescreen(),
      },

      initialRoute: '/',
      
    );
  }
}
