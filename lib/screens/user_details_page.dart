import 'package:artenativ/models/ItemDataModel.dart';
import 'package:flutter/material.dart';
import 'package:artenativ/models/ItemDataModel.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetailsPage extends StatefulWidget {
  final ItemDataModel items;

  UserDetailsPage({required this.items});

  @override
  _UserDetailsPageState createState() =>
      _UserDetailsPageState(items: this.items);
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final ItemDataModel items;
  _UserDetailsPageState({required this.items});

  /*
  String userTitle() {
    String title = "";
    if (items.gender == "Male") {
      title = "Mr.";
    } else if (items.gender == "Female") {
      title = "Ms.";
    }
    return title;
  }
  */

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('${items.lieferant} ${items.artikeltyp} ${items.kategorie}'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 16.0,
            ),
            Center(
              child: Hero(
                tag: items.id,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(items.image),
                  radius: 100.0,
                ),
              ),
            ),
            SizedBox(
              height: 22.0,
            ),
            Text(
              '${items.lieferant} ${items.artikeltyp} ${items.kategorie}',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(
              '${items.kategorie}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${items.material}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.left,
                ),
                FlatButton(
                  onPressed: () {
                    customLaunch(
                        'mailto:${items.material}?subject=Contact%20Information&body=Type%20your%20mail%20here');
                  },
                  child: Icon(
                    Icons.email,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, bottom: 20.0),
                  child: Text(
                    items.dimension,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
