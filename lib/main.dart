import 'package:artenativ/home.dart';
import 'package:artenativ/login.dart';
import 'package:artenativ/services/shared_service.dart';
import 'package:artenativ/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:uni_links_desktop/uni_links_desktop.dart';
import 'dismisskeyboard.dart';
import 'dart:io';

Widget _defaultHome = const LoginScreen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get result of the login function.
  /*bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = const HomePage();
  }*/
  if (Platform.isMacOS || Platform.isWindows) {
    enableUniLinksDesktop();
    if (Platform.isWindows) {
      registerProtocol('unilinks');
    }
  }

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
        routes: {
          '/': (context) => _defaultHome,
          '/home': (context) => const HomePage(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const SignUpScreen(),
        },
        //home: const HomePage(),
      ),
    );
  }
}
