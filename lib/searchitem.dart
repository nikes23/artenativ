import 'package:flutter/material.dart';

class SearchItemScreen extends StatefulWidget {
  const SearchItemScreen({Key? key}) : super(key: key);

  @override
  _SearchItemScreenState createState() => _SearchItemScreenState();
}

class _SearchItemScreenState extends State<SearchItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Suchen'),
        backgroundColor: const Color(0xFFF76A25),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          )
        ],
      ),
      //drawer: const ChatDrawer(),
      body: const Center(
        child: Text('Suchen'),
      ),
    );
  }
}
