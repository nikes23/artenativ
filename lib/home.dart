import 'package:artenativ/additems.dart';
import 'package:artenativ/login.dart';
import 'package:artenativ/searchitem.dart';
import 'package:artenativ/settings.dart';
import 'package:artenativ/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      theme: ThemeData(
        primaryColor: const Color(0xFFF76A25),
        colorScheme: ColorScheme.light().copyWith(
          primary: const Color(0xFFF76A25),
          secondary: const Color(0xFFF76A25),
        ),
        //disabledColor: Colors.grey,

        /*colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xFFF76Ap25),
              secondary: const Color(0xFFF76A25)),*/
      ),
      routes: {
        '/': (context) => const MyBottomNavigationBar(),
        '/home': (context) => const MyBottomNavigationBar(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const SignUpScreen(),
      },

      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),

      //home: const MyBottomNavigationBar(),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 1;
  var themeMode = true;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _pages = [
    const SearchItemScreen(),
    const AddItemsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    //var darkMode = themeMode;
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: (themeMode == true)
            ? const Color(0xFFF76A25)
            : const Color(0xFFFFFFFF),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Suchen'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Erfassen'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Einstellungen'),
        ],
      ),
    );
  }
}
