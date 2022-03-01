import 'dart:developer';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'globals.dart' as globals;
import 'package:artenativ/home.dart';
import 'package:artenativ/login.dart';
import 'package:flutter/material.dart';

class AddItemsScreen extends StatefulWidget {
  const AddItemsScreen({Key? key}) : super(key: key);

  @override
  _AddItemsScreenState createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _firstName = '';
  String _lastName = '';
  String _phoneNumber = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _userStatus = '';
  bool _isHidden = true;

  String? localHersteller;
  String? localArtikeltyp;
  String? localKategorie;

  File? image;
  var imageContainer;

  @override
  void initState() {
    localHersteller = globals.selectedHersteller;
    localArtikeltyp = globals.selectedArtikeltyp;
    localKategorie = globals.selectedKategorie;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Erfassen'),
        backgroundColor: const Color(0xFFF76A25),
        /*actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          )
        ],*/
      ),
      //drawer: const ChatDrawer(),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                        top: 60.0, right: 20.0, left: 20.0, bottom: 20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 600,
                            child: Center(
                              child: Text(
                                'Artikel erfassen',
                                style: TextStyle(
                                  color: Color(0xFFF76A25),
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          getListView(context),
                          //Hersteller
                          /*SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Hersteller*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  //validator: UserNameValidator.validate,
                                  style: const TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                  decoration: buildSignUpInputDecoration(
                                      'Herstellername eingeben', Icons.house),
                                  onSaved: (value) => _firstName = value!,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Bitte geben Sie den Herstellernamen ein';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),*/
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Hersteller*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                DropdownButtonFormField(
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: const BorderSide(
                                          width: 2, color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: const BorderSide(
                                          width: 2, color: Color(0xFFF76A25)),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  validator: (value) => value == null
                                      ? "Wählen Sie bitte einen Hersteller aus!"
                                      : null,
                                  dropdownColor: Colors.white,
                                  value: globals.selectedHersteller,
                                  onChanged: (hersteller) {
                                    /*if (hersteller == 'Fliesen') {
                                      globals.kategorien =
                                          globals.fliesenKategorie;
                                    } else if (hersteller == 'Parkett') {
                                      globals.kategorien =
                                          globals.parkettKategorie;
                                    } else if (hersteller == 'Designbeläge') {
                                      globals.kategorien =
                                          globals.designKategorie;
                                    } else if (hersteller == 'Treppen') {
                                      globals.kategorien =
                                          globals.treppenKategorie;
                                    } else if (hersteller == null) {
                                      setState(() {
                                        var glob;
                                        globals.kategorien = [];
                                        glob = globals.kategorien;
                                        log('LogELSE: $glob');
                                      });
                                    } else {
                                      setState(() {
                                        var glob;
                                        globals.kategorien = [];
                                        glob = globals.kategorien;
                                        log('LogELSE: $glob');
                                      });
                                    }
                                    setState(() {
                                      globals.selectedKategorie = null;
                                      globals.selectedHersteller =
                                      hersteller! as String?;

                                      localHersteller =
                                          globals.selectedHersteller;
                                      log('Hersteller: ' +
                                          globals.selectedHersteller!);
                                    });*/
                                  },
                                  items: globals.herstellerListe,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          //Artikelnummer Hersteller
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Artikelnummer Hersteller*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  //validator: UserNameValidator.validate,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration: buildSignUpInputDecorationImage(
                                      'Artikelnummer eingeben',
                                      AssetImage("assets/barcode.png")),
                                  onSaved: (value) => _lastName = value!,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Bitte geben Sie die Artikelnummer vom Hersteller ein';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          //Artikelnummer Intern
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Artikelnummer Intern*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  //validator: UserNameValidator.validate,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration: buildSignUpInputDecorationImage(
                                    'Artikelnummer eingeben',
                                    AssetImage("assets/barcode.png"),
                                  ),
                                  onSaved: (value) => _lastName = value!,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Bitte geben Sie die interne Artikelnummer ein';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          //Ausstellplatz
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: const [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Ausstellplatz*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                DropdownAusstellungsplatz(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          //Artikeltyp
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Artikeltyp*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                DropdownButtonFormField(
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: const BorderSide(
                                          width: 2, color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: const BorderSide(
                                          width: 2, color: Color(0xFFF76A25)),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  validator: (value) => value == null
                                      ? "Wählen Sie bitte einen Artikeltyp aus!"
                                      : null,
                                  dropdownColor: Colors.white,
                                  value: globals.selectedArtikeltyp,
                                  onChanged: (artikeltyp) {
                                    if (artikeltyp == 'Fliesen') {
                                      globals.kategorien =
                                          globals.fliesenKategorie;
                                    } else if (artikeltyp == 'Parkett') {
                                      globals.kategorien =
                                          globals.parkettKategorie;
                                    } else if (artikeltyp == 'Designbeläge') {
                                      globals.kategorien =
                                          globals.designKategorie;
                                    } else if (artikeltyp == 'Treppen') {
                                      globals.kategorien =
                                          globals.treppenKategorie;
                                    } else if (artikeltyp == null) {
                                      setState(() {
                                        var glob;
                                        globals.kategorien = [];
                                        glob = globals.kategorien;
                                        log('LogELSE: $glob');
                                      });
                                    } else {
                                      setState(() {
                                        var glob;
                                        globals.kategorien = [];
                                        glob = globals.kategorien;
                                        log('LogELSE: $glob');
                                      });
                                    }
                                    setState(() {
                                      globals.selectedKategorie = null;
                                      globals.selectedArtikeltyp =
                                          artikeltyp! as String?;

                                      localArtikeltyp =
                                          globals.selectedArtikeltyp;
                                      log('Artikeltyp: ' +
                                          globals.selectedArtikeltyp!);
                                    });
                                  },
                                  items: globals.artikeltypen,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          /**if (localArtikeltyp != null) ...[
                            Text(
                              'Artikeltyp: ' + localArtikeltyp!,
                            )
                          ] else ...[
                            Text(
                              'Artikeltyp: ' + 'Null',
                            )
                          ],*/
                          //Kategorien
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Kategorie*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                DropdownButtonFormField(
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  hint: const Text(
                                    '- Kategorie auswählen -',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: const BorderSide(
                                          width: 2, color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: const BorderSide(
                                          width: 2, color: Color(0xFFF76A25)),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  validator: (value) => value == null
                                      ? "Wählen Sie bitte eine Kategorie aus!"
                                      : null,
                                  dropdownColor: Colors.white,
                                  value: globals.selectedKategorie,
                                  onChanged: (kategorie) {
                                    setState(() {
                                      globals.selectedKategorie =
                                          kategorie as String?;
                                      localKategorie =
                                          globals.selectedKategorie;
                                    });
                                  },
                                  items: globals.kategorien.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          /**if (localKategorie != null) ...[
                            Text(
                              'Kategorie: ' + localKategorie!,
                            )
                          ] else ...[
                            Text(
                              'Kategorie: ' + 'Null',
                            )
                          ],*/
                          const SizedBox(
                            width: 600,
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 20.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '* Pflichtfelder',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          buildButtonContainer(),
                          //getListView(context),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration buildSignUpInputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.black,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(width: 2, color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(width: 2, color: Color(0xFFF76A25)),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      prefixIcon: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }

  InputDecoration buildSignUpInputDecorationImage(
      String hint, AssetImage icon) {
    return InputDecoration(
      prefixIcon: Transform.scale(
        scale: 0.5,
        child: ImageIcon(
          icon,
          color: Colors.black,
        ),
      ),
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.black,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(width: 2, color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(width: 2, color: Color(0xFFF76A25)),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  Widget buildButtonContainer() {
    return Container(
      height: 56.0,
      //width: MediaQuery.of(context).size.width,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFFF76A25),
      ),
      child: MaterialButton(
          child: const Text(
            'Speichern',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23.0,
            ),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomePage(),
                      fullscreenDialog: true));
            }
          }),
    );
  }

  Widget getListView(BuildContext context) {
    Future pickImage(ImageSource source) async {
      try {
        final image = await ImagePicker().pickImage(source: source);
        if (image == null) return;
        final imageTemporary = File(image.path);
        setState(() => this.image = imageTemporary);
      } on PlatformException catch (e) {
        if (kDebugMode) {
          print('Bild auswählen fehlgeschlagen: $e');
        }
      }
    }

    var listView = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
          child: image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.file(
                    image!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ))
              /*ClipOval(
              child: Image.file(
              image!,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
              ))*/
              : Image.asset(
                  'assets/Artenativ_Logo_Schwarz.png',
                  width: 300,
                  fit: BoxFit.cover,
                ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 5.0),
          child: SizedBox(
            //width: MediaQuery.of(context).size.width,
            width: 300,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFF76A25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () => pickImage(ImageSource.camera),
              child: const ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  size: 23.0,
                  color: Colors.white,
                ),
                title: Text(
                  "Bild aufnehmen",
                  style: TextStyle(color: Colors.white, fontSize: 23.0),
                ),
                /**onTap: () {
                    },*/
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 30.0),
          child: SizedBox(
            //width: MediaQuery.of(context).size.width,
            width: 300,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFF76A25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () => pickImage(ImageSource.gallery),
              child: const ListTile(
                leading: Icon(
                  Icons.image,
                  size: 23.0,
                  color: Colors.white,
                ),
                title: Text(
                  "Bild auswählen",
                  style: TextStyle(color: Colors.white, fontSize: 23.0),
                ),
                /**onTap: () {
                    },*/
              ),
            ),
          ),
        ),
      ],
    );
    debugPrint('Bild: $image');
    return listView;
  }

  void navigateToSignIn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginScreen(), fullscreenDialog: true));
  }
}

class DropdownAusstellungsplatz extends StatefulWidget {
  const DropdownAusstellungsplatz({Key? key}) : super(key: key);

  @override
  _DropdownAusstellungsplatzState createState() =>
      _DropdownAusstellungsplatzState();
}

class _DropdownAusstellungsplatzState extends State<DropdownAusstellungsplatz> {
  String? selectedValue = null;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        icon: Icon(Icons.keyboard_arrow_down),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(width: 2, color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(width: 2, color: Color(0xFFF76A25)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) =>
            value == null ? "Wählen Sie bitte einen Ausstellplatz aus!" : null,
        dropdownColor: Colors.white,
        value: selectedValue,
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
        items: dropdownAusstellungsplatz);
  }

  List<DropdownMenuItem<String>> get dropdownAusstellungsplatz {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text("- Ausstellplatz auswählen -"), value: null),
      const DropdownMenuItem(child: Text("A"), value: "A"),
      const DropdownMenuItem(child: Text("B"), value: "B"),
      const DropdownMenuItem(child: Text("C"), value: "C"),
      const DropdownMenuItem(child: Text("D"), value: "D"),
      const DropdownMenuItem(child: Text("E"), value: "E"),
      const DropdownMenuItem(child: Text("F"), value: "F"),
      const DropdownMenuItem(child: Text("G"), value: "G"),
      const DropdownMenuItem(child: Text("H"), value: "H"),
      const DropdownMenuItem(child: Text("I"), value: "I"),
      const DropdownMenuItem(child: Text("Z"), value: "Z"),
    ];
    return menuItems;
  }
}
