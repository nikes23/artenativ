import 'package:artenativ/additemsextend.dart';
import 'package:flutter/material.dart';
import 'package:artenativ/ItemDataModel.dart';
import 'package:artenativ/screens/user_details_page.dart';

class UserTile extends StatelessWidget {
  final ItemDataModel items;

  UserTile({required this.items});

  /**String userTitle() {
    String title = "";
    if (items.gender == "Male") {
      title = "Mr.";
    } else if (items.gender == "Female") {
      title = "Ms.";
    }
    return title;
  }*/

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          GestureDetector(
            child: Card(
              elevation: 3,
              child: Row(
                children: [
                  /*SizedBox(
                    width: MediaQuery.of(context).size.width * 0.33,
                    child: Image.asset(
                      "assets/images/banane.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                    child: Hero(
                      tag: items.id,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(items.image),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Lieferant: ",
                                style: new TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFF76A25),
                                ),
                              ),
                              Text(
                                "${items.lieferant}",
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          new Text(
                            "Artikeltyp: ${items.artikeltyp}",
                            style: new TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            'Kategorie: ${items.kategorie}',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddItemsExtendScreen(items: items)));
            },
          ),
        ],
      ),
    );
  }
}

/*
@override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            leading: Hero(
              tag: items.id,
              child: CircleAvatar(
                backgroundImage: NetworkImage(items.image),
              ),
            ),
            title: Text('Lieferant: ${items.lieferant} ${items.artikeltyp}'),
            subtitle: Text('Kategorie: ${items.kategorie}'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserDetailsPage(items: items)));
            },
          ),
          Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
 */
