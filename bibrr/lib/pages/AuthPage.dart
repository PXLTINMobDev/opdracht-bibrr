import 'package:bibrr/screens/book_list_page_screen.dart';
import 'package:bibrr/screens/login_page_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(), 
          builder: (context, snapshot)
          {
            if(snapshot.hasData){
              return const Booklistpagescreen();
            } else {
              return Loginpagescreen();
            }
          },
        )
    );
  }
}