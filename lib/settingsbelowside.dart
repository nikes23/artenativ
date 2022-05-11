import 'package:flutter/material.dart';

class SettingsBelowScreen extends StatefulWidget {
  final String title;
  const SettingsBelowScreen({Key? key, required this.title}) : super(key: key);

  @override
  _SettingsBelowScreenState createState() =>
      _SettingsBelowScreenState(title: title);
}

class _SettingsBelowScreenState extends State<SettingsBelowScreen> {
  final String title;
  _SettingsBelowScreenState({required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(title),
        backgroundColor: const Color(0xFFF76A25),
      ),
      body: SafeArea(
        child: Center(
          child: Center(
            child: Text(
              title + ' Seite',
              style: const TextStyle(
                color: Color(0xFFF76A25),
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
