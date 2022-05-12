import 'package:artenativ/components/qrscanner.dart';
import 'package:artenativ/globals.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:http/http.dart' as http;
import 'domain/repository.dart';
import 'globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:artenativ/components/user_tile.dart';
import 'package:artenativ/components/loading_widget.dart';
import 'package:artenativ/models/artikel_request.dart';

class SearchItemScreen extends StatefulWidget {
  const SearchItemScreen({Key? key}) : super(key: key);

  @override
  _SearchItemScreenState createState() => _SearchItemScreenState();
}

class _SearchItemScreenState extends State<SearchItemScreen> {
  final List<Artikel> _items = <Artikel>[];
  List<Artikel> _itemsDisplay = <Artikel>[];

  final TextEditingController _textController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    //ReadJsonData().then((value) {
    LiveJsonData().then((value) {
      setState(() {
        _isLoading = false;
        _items.addAll(value);
        _itemsDisplay = _items;
        print(_itemsDisplay.length);
      });
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
            child: IconButton(
                icon: const Icon(Icons.qr_code_scanner),
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Stack(
                                    children: [
                                      QRScannerScreen(
                                          overlayColour:
                                              Colors.black.withOpacity(0.5)),
                                    ],
                                  ),
                              fullscreenDialog: true))
                      .then((value) => setState(() {
                            if (qrcodeResult != null) {
                            } else {}
                          }));
                }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ),
        ],
      ),
      //drawer: const ChatDrawer(),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) {
            if (!_isLoading) {
              return index == 0
                  ? _searchBar()
                  //: UserTile(items: this._itemsDisplay[index - 1]);
                  : UserTile(items: _itemsDisplay[index - 1]);
            } else {
              return LoadingView();
            }
          },
          itemCount: _itemsDisplay.length + 1,
        ),
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        autofocus: false,
        onChanged: (searchText) {
          searchText = searchText.toLowerCase();
          setState(() {
            _itemsDisplay = _items.where((u) {
              var lieferant = u.lieferant.toLowerCase();
              var artikeltyp = u.artikeltyp.toLowerCase();
              var kategorie = u.kategorie.toLowerCase();
              return lieferant.contains(searchText) ||
                  artikeltyp.contains(searchText) ||
                  kategorie.contains(searchText);
            }).toList();
          });
        },
        controller: _textController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _textController.clear();
              setState(() {
                _itemsDisplay = _items;
              });
            },
            color: Colors.black,
            splashColor: const Color(0xFFF76A25),
          ),
          hintText: 'Artikel suchen',
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFFF76A25)),
          ),
          focusColor: const Color(0xFFF76A25),
        ),
      ),
    );
  }
}
