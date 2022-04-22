import 'dart:convert';
import 'dart:developer';
import 'dart:async';
import 'dart:io';
import 'package:artenativ/models/ItemDataModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;
import 'package:artenativ/home.dart';
import 'package:artenativ/login.dart';
import 'package:flutter/material.dart';

import 'globals.dart';

class SearchItemScreen extends StatefulWidget {
  const SearchItemScreen({Key? key}) : super(key: key);

  @override
  _SearchItemScreenState createState() => _SearchItemScreenState();
}

class _SearchItemScreenState extends State<SearchItemScreen> {
  /**Future getItemData() async {
      var response =
      await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
      var jsonData = jsonDecode(response.body);
      List<User> users = [];

      for (var u in jsonData) {
      User user = User(u["name"], u["email"], u["username"]);
      users.add(user);
      }
      print(users.length);
      return users;
      }*/

  /**
   * static List<String> lieferanten = [
      'Admonter',
      'Alu Plan',
      'Amorim',
      'Amtico',
      'Bauwerk',
      'Bärwolf',
      'Becker Großgarten',
      'Belopa',
      'Biehler',
      'Brich',
      'BTI',
      'Buchner'
      ];

      static List artikeltypen = [
      'Parkett',
      'Profile',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Hapus_Mango.jpg/220px-Hapus_Mango.jpg',
      'https://5.imimg.com/data5/VN/YP/MY-33296037/orange-600x600-500x500.jpg',
      'https://5.imimg.com/data5/GJ/MD/MY-35442270/fresh-pineapple-500x500.jpg'
      ];
   */

  Future<List<ItemDataModel>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('jsonfile/productlist.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => ItemDataModel.fromJson(e)).toList();
  }

  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    //_foundUsers = ReadJsonData() as List<Map<String, dynamic>>;
    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Suche', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundUsers[index]["id"]),
                        color: Colors.amberAccent,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Text(
                            _foundUsers[index]["id"].toString(),
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(_foundUsers[index]['name']),
                          subtitle: Text(
                              '${_foundUsers[index]["age"].toString()} years old'),
                        ),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
/**
    class User {
    final String name, email, userName;
    User(this.name, this.email, this.userName);
    }
 */
