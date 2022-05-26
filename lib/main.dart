import 'package:flutter/material.dart';
import 'package:flutter_bloc_ex/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF292828)),
        scaffoldBackgroundColor: const Color(0xFF292828),
        brightness: Brightness.dark,
      ),
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
