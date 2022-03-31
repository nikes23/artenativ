import 'package:artenativ/additems.dart';
import 'package:artenativ/searchitem.dart';
import 'package:artenativ/settings.dart';
import 'package:flutter/material.dart';

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
        /*colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xFFF76Ap25),
              secondary: const Color(0xFFF76A25)),*/
      ),
      home: const MyBottomNavigationBar(),
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
