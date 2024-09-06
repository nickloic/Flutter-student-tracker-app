import 'package:application_de_suivie_etudiant/screens/home.dart';
import 'package:flutter/material.dart';
import './screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'suivi etudiant',
      // home: Login()
      home: Home(codeMatiere: 'PROG_SQL',)
    );
  }
}
