import 'package:artenativ/home.dart';
import 'package:flutter/material.dart';
import 'dismisskeyboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFFF76A25),
          colorScheme: ColorScheme.light().copyWith(
            primary: const Color(0xFFF76A25),
            secondary: const Color(0xFFF76A25),
          ),
          /*colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xFFF76A25),
              secondary: const Color(0xFFF76A25)),*/
        ),
        title: 'Artenativ',
        /*theme: ThemeData(
          primarySwatch: Colors.blue,
        ),*/
        home: const HomePage(),
      ),
    );
  }
}
