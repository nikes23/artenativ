import 'dart:developer';
import 'dart:async';
import 'dart:io';
import 'package:artenativ/config.dart';
import 'package:artenativ/models/addartikel_request_model.dart';
import 'package:artenativ/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;
import 'package:artenativ/home.dart';
import 'package:artenativ/login.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

class AddItemsScreen extends StatefulWidget {
  const AddItemsScreen({Key? key}) : super(key: key);

  @override
  _AddItemsScreenState createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  String? imageName;

  final _formKey = GlobalKey<FormState>();

  var file, extention, imagePath;
  var id = '1';
  var name = 'a';

  String response = '';

  String? localHersteller;
  String? localArtikeltyp;
  String? localKategorie;
  String? localBeanspruchung;
  String? localVerfugbarkeit;
  String? localMaterial;

  //Variables for Textfields Content
  String? _artNrLieferant = '';
  //String? _artNrIntern = '';
  String? _eanBarcode = '';
  String? _dimension = '';
  String? _haptik = '';
  String? _optik = '';

  TextEditingController artNrLieferantController = TextEditingController();
  //TextEditingController artNrInternController = TextEditingController();
  TextEditingController eanBarcodeController = TextEditingController();
  TextEditingController dimensionController = TextEditingController();
  TextEditingController haptikController = TextEditingController();
  TextEditingController optikController = TextEditingController();

  File? image;
  var imageContainer;

  @override
  void initState() {
    localHersteller = globals.selectedHersteller;
    localArtikeltyp = globals.selectedArtikeltyp;
    localKategorie = globals.selectedKategorie;
    _artNrLieferant = artNrLieferantController.text;
    //_artNrIntern = artNrInternController.text;
    _eanBarcode = eanBarcodeController.text;
    localMaterial = globals.selectedMaterial;
    _dimension = dimensionController.text;
    _haptik = haptikController.text;
    _optik = optikController.text;
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    artNrLieferantController.dispose();
    //artNrInternController.dispose();
    eanBarcodeController.dispose();
    dimensionController.dispose();
    haptikController.dispose();
    optikController.dispose();
    _formKey.currentState?.reset();
    super.dispose();
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
                          //Lieferant
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Lieferant*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                DropdownButtonFormField(
                                  hint: const Text(
                                    '- Lieferant auswählen -',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  icon: const Icon(Icons.keyboard_arrow_down),
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
                                      ? "Wählen Sie bitte einen Lieferanten aus!"
                                      : null,
                                  dropdownColor: Colors.white,
                                  value: globals.selectedHersteller,
                                  onSaved: (value) =>
                                      globals.selectedHersteller,
                                  onChanged: (hersteller) {
                                    if (hersteller == 'Admonter') {
                                      globals.artTypen = globals.admonter;
                                      clearHersteller();
                                    } else if (hersteller == 'Alu Plan') {
                                      globals.artTypen = globals.aluPlan;
                                      clearHersteller();
                                    } else if (hersteller == 'Amorim') {
                                      globals.artTypen = globals.amorim;
                                      clearHersteller();
                                    } else if (hersteller == 'Amtico') {
                                      globals.artTypen = globals.amtico;
                                      clearHersteller();
                                    } else if (hersteller == 'Bauwerk') {
                                      globals.artTypen = globals.bauwerk;
                                      clearHersteller();
                                    } else if (hersteller == 'Bärwolf') {
                                      globals.artTypen = globals.baerwolf;
                                      clearHersteller();
                                    } else if (hersteller ==
                                        'Becker Großgarten') {
                                      globals.artTypen = globals.becker;
                                      clearHersteller();
                                    } else if (hersteller == 'Belopa') {
                                      globals.artTypen = globals.belopa;
                                      clearHersteller();
                                    } else if (hersteller == 'Biehler') {
                                      globals.artTypen = globals.biehler;
                                      clearHersteller();
                                    } else if (hersteller == 'Brich') {
                                      globals.artTypen = globals.brich;
                                      clearHersteller();
                                    } else if (hersteller == 'BTI') {
                                      globals.artTypen = globals.bti;
                                      clearHersteller();
                                    } else if (hersteller == 'Buchner') {
                                      globals.artTypen = globals.buchner;
                                      clearHersteller();
                                    } else if (hersteller ==
                                        'Burger Holzzentrum') {
                                      globals.artTypen = globals.burgerHolz;
                                      clearHersteller();
                                    } else if (hersteller == 'Christ') {
                                      globals.artTypen = globals.christ;
                                      clearHersteller();
                                    } else if (hersteller == 'Climacell') {
                                      globals.artTypen = globals.climacell;
                                      clearHersteller();
                                    } else if (hersteller == 'Dahm') {
                                      globals.artTypen = globals.dahm;
                                      clearHersteller();
                                    } else if (hersteller == 'Denzel') {
                                      globals.artTypen = globals.denzel;
                                      clearHersteller();
                                    } else if (hersteller == 'Desso') {
                                      globals.artTypen = globals.desso;
                                      clearHersteller();
                                    } else if (hersteller == 'Dekora') {
                                      globals.artTypen = globals.dekora;
                                      clearHersteller();
                                    } else if (hersteller == 'Döllken') {
                                      globals.artTypen = globals.doellken;
                                      clearHersteller();
                                    } else if (hersteller == 'Dr. Schutz') {
                                      globals.artTypen = globals.schutz;
                                      clearHersteller();
                                    } else if (hersteller == 'Dura') {
                                      globals.artTypen = globals.dura;
                                      clearHersteller();
                                    } else if (hersteller == 'Dural') {
                                      globals.artTypen = globals.dural;
                                      clearHersteller();
                                    } else if (hersteller ==
                                        'Effektiv Werkzeug') {
                                      globals.artTypen =
                                          globals.effektivWerkzeug;
                                      clearHersteller();
                                    } else if (hersteller == 'Enia') {
                                      globals.artTypen = globals.enia;
                                      clearHersteller();
                                    } else if (hersteller == 'Ewifoam') {
                                      globals.artTypen = globals.ewifoam;
                                      clearHersteller();
                                    } else if (hersteller == 'Fabromont') {
                                      globals.artTypen = globals.fabromont;
                                      clearHersteller();
                                    } else if (hersteller == 'Fetim') {
                                      globals.artTypen = globals.fetim;
                                      clearHersteller();
                                    } else if (hersteller ==
                                        'Fulda Filzfabrik') {
                                      globals.artTypen =
                                          globals.fuldaFilzfabrik;
                                      clearHersteller();
                                    } else if (hersteller == 'Futura Floors') {
                                      globals.artTypen = globals.futuraFloors;
                                      clearHersteller();
                                    } else if (hersteller == 'Floors 4ever') {
                                      globals.artTypen = globals.floorsEver;
                                      clearHersteller();
                                    } else if (hersteller == 'Forbo Eurocool') {
                                      globals.artTypen = globals.forboEurocool;
                                      clearHersteller();
                                    } else if (hersteller == 'Forbo Flooring') {
                                      globals.artTypen = globals.forboFlooring;
                                      clearHersteller();
                                    } else if (hersteller == 'Gerflor') {
                                      globals.artTypen = globals.gerflor;
                                      clearHersteller();
                                    } else if (hersteller == 'Götz Carl') {
                                      globals.artTypen = globals.gotzCarl;
                                      clearHersteller();
                                    } else if (hersteller == 'Gunreben') {
                                      globals.artTypen = globals.gunreben;
                                      clearHersteller();
                                    } else if (hersteller == 'GW Tischler') {
                                      globals.artTypen = globals.gwTischler;
                                      clearHersteller();
                                    } else if (hersteller == 'Harrer') {
                                      globals.artTypen = globals.harrer;
                                      clearHersteller();
                                    } else if (hersteller == 'Hasit') {
                                      globals.artTypen = globals.hasit;
                                      clearHersteller();
                                    } else if (hersteller == 'Hocotimber') {
                                      globals.artTypen = globals.hocotimber;
                                      clearHersteller();
                                    } else if (hersteller == 'Hanke') {
                                      globals.artTypen = globals.hanke;
                                      clearHersteller();
                                    } else if (hersteller == 'Intercell') {
                                      globals.artTypen = globals.intercell;
                                      clearHersteller();
                                    } else if (hersteller == 'Janser') {
                                      globals.artTypen = globals.janser;
                                      clearHersteller();
                                    } else if (hersteller == 'Jasba') {
                                      globals.artTypen = globals.jasba;
                                      clearHersteller();
                                    } else if (hersteller == 'Jäger') {
                                      globals.artTypen = globals.jaeger;
                                      clearHersteller();
                                    } else if (hersteller == 'JEP') {
                                      globals.artTypen = globals.jep;
                                      clearHersteller();
                                    } else if (hersteller == 'Jordan') {
                                      globals.artTypen = globals.jordan;
                                      clearHersteller();
                                    } else if (hersteller == 'Keskin') {
                                      globals.artTypen = globals.keskin;
                                      clearHersteller();
                                    } else if (hersteller == 'KGM') {
                                      globals.artTypen = globals.kgm;
                                      clearHersteller();
                                    } else if (hersteller == 'KLB') {
                                      globals.artTypen = globals.klb;
                                      clearHersteller();
                                    } else if (hersteller == 'Koeber') {
                                      globals.artTypen = globals.koeber;
                                      clearHersteller();
                                    } else if (hersteller == 'Küblböck') {
                                      globals.artTypen = globals.kueblboeck;
                                      clearHersteller();
                                    } else if (hersteller == 'KWG') {
                                      globals.artTypen = globals.kwg;
                                      clearHersteller();
                                    } else if (hersteller == 'Martin Meier') {
                                      globals.artTypen = globals.martinMeier;
                                      clearHersteller();
                                    } else if (hersteller == 'Mayer Bauz') {
                                      globals.artTypen = globals.mayerBauz;
                                      clearHersteller();
                                    } else if (hersteller == 'Murexin') {
                                      globals.artTypen = globals.murexin;
                                      clearHersteller();
                                    } else if (hersteller == 'NBO') {
                                      globals.artTypen = globals.nbo;
                                      clearHersteller();
                                    } else if (hersteller == 'Neuhofer') {
                                      globals.artTypen = globals.neuhofer;
                                      clearHersteller();
                                    } else if (hersteller == 'Norwork') {
                                      globals.artTypen = globals.norwork;
                                      clearHersteller();
                                    } else if (hersteller == 'Meister Werke') {
                                      globals.artTypen = globals.meisterWerke;
                                      clearHersteller();
                                    } else if (hersteller == 'Objectflor') {
                                      globals.artTypen = globals.objectflor;
                                      clearHersteller();
                                    } else if (hersteller == 'Ochs') {
                                      globals.artTypen = globals.ochs;
                                      clearHersteller();
                                    } else if (hersteller == 'Oster') {
                                      globals.artTypen = globals.oster;
                                      clearHersteller();
                                    } else if (hersteller == 'Otto Chemie') {
                                      globals.artTypen = globals.ottoChemie;
                                      clearHersteller();
                                    } else if (hersteller == 'Pallmann') {
                                      globals.artTypen = globals.pallmann;
                                      clearHersteller();
                                    } else if (hersteller == 'Parigiani') {
                                      globals.artTypen = globals.parigiani;
                                      clearHersteller();
                                    } else if (hersteller == 'Scheffold') {
                                      globals.artTypen = globals.scheffold;
                                      clearHersteller();
                                    } else if (hersteller == 'Solum') {
                                      globals.artTypen = globals.solum;
                                      clearHersteller();
                                    } else if (hersteller == 'Pfahler') {
                                      globals.artTypen = globals.pfahler;
                                      clearHersteller();
                                    } else if (hersteller == 'PNZ') {
                                      globals.artTypen = globals.pnz;
                                      clearHersteller();
                                    } else if (hersteller == 'Prinz Carl') {
                                      globals.artTypen = globals.prinzCarl;
                                      clearHersteller();
                                    } else if (hersteller == 'Project Floors') {
                                      globals.artTypen = globals.projectFloors;
                                      clearHersteller();
                                    } else if (hersteller == 'Raab Karcher') {
                                      globals.artTypen = globals.raabKarcher;
                                      clearHersteller();
                                    } else if (hersteller == 'Reincke') {
                                      globals.artTypen = globals.reincke;
                                      clearHersteller();
                                    } else if (hersteller == 'Repack') {
                                      globals.artTypen = globals.repack;
                                      clearHersteller();
                                    } else if (hersteller == 'Sonat') {
                                      globals.artTypen = globals.sonat;
                                      clearHersteller();
                                    } else if (hersteller == 'Sonnenpartner') {
                                      globals.artTypen = globals.sonnenpartner;
                                      clearHersteller();
                                    } else if (hersteller == 'Schimmer') {
                                      globals.artTypen = globals.schimmer;
                                      clearHersteller();
                                    } else if (hersteller == 'Schlau') {
                                      globals.artTypen = globals.schlau;
                                      clearHersteller();
                                    } else if (hersteller == 'Schlingelhoff') {
                                      globals.artTypen = globals.schlingelhoff;
                                      clearHersteller();
                                    } else if (hersteller == 'Schmitt B') {
                                      globals.artTypen = globals.schmittB;
                                      clearHersteller();
                                    } else if (hersteller == 'Schuhböcks') {
                                      globals.artTypen = globals.schuhboecks;
                                      clearHersteller();
                                    } else if (hersteller == 'Schuller') {
                                      globals.artTypen = globals.schuller;
                                      clearHersteller();
                                    } else if (hersteller == 'Stauf') {
                                      globals.artTypen = globals.stauf;
                                      clearHersteller();
                                    } else if (hersteller == 'Tagia') {
                                      globals.artTypen = globals.tagia;
                                      clearHersteller();
                                    } else if (hersteller == 'Tapes Tools') {
                                      globals.artTypen = globals.tapesTools;
                                      clearHersteller();
                                    } else if (hersteller == 'Taxis') {
                                      globals.artTypen = globals.taxis;
                                      clearHersteller();
                                    } else if (hersteller == 'TFD') {
                                      globals.artTypen = globals.tfd;
                                      clearHersteller();
                                    } else if (hersteller == 'Thede Witte') {
                                      globals.artTypen = globals.thedeWitte;
                                      clearHersteller();
                                    } else if (hersteller == 'Templer') {
                                      globals.artTypen = globals.templer;
                                      clearHersteller();
                                    } else if (hersteller == 'Thalhofer') {
                                      globals.artTypen = globals.thalhofer;
                                      clearHersteller();
                                    } else if (hersteller == 'Upofloor') {
                                      globals.artTypen = globals.upofloor;
                                      clearHersteller();
                                    } else if (hersteller == 'Vorwerk') {
                                      globals.artTypen = globals.vorwerk;
                                      clearHersteller();
                                    } else if (hersteller == 'Wakol') {
                                      globals.artTypen = globals.wakol;
                                      clearHersteller();
                                    } else if (hersteller == 'Weitzer') {
                                      globals.artTypen = globals.weitzer;
                                      clearHersteller();
                                    } else if (hersteller == 'Windmöller') {
                                      globals.artTypen = globals.windmoeller;
                                      clearHersteller();
                                    } else if (hersteller == 'Würth') {
                                      globals.artTypen = globals.wuerth;
                                      clearHersteller();
                                    } else if (hersteller == 'ZEG') {
                                      globals.artTypen = globals.zeg;
                                      clearHersteller();
                                    } else if (hersteller == null) {
                                      setState(() {
                                        List<String> artTyp;
                                        globals.artTypen = [];
                                        artTyp = globals.artTypen;
                                        log('LogELSE: $artTyp');
                                        List<String> kategorie;
                                        globals.kategorien = [];
                                        kategorie = globals.kategorien;
                                        log('LogELSE: $kategorie');
                                        List<String> material;
                                        globals.materialien = [];
                                        material = globals.materialien;
                                        log('LogELSE: $material');
                                      });
                                    } else {
                                      setState(() {
                                        List<String> artTyp;
                                        globals.artTypen = [];
                                        artTyp = globals.artTypen;
                                        log('LogELSE: $artTyp');
                                        List<String> kategorie;
                                        globals.kategorien = [];
                                        kategorie = globals.kategorien;
                                        log('LogELSE: $kategorie');
                                        List<String> material;
                                        globals.materialien = [];
                                        material = globals.materialien;
                                        log('LogELSE: $material');
                                      });
                                    }
                                    setState(() {
                                      globals.selectedArtikeltyp = null;
                                      globals.selectedKategorie = null;
                                      globals.selectedMaterial = null;
                                      globals.selectedHersteller =
                                          hersteller! as String?;

                                      localHersteller =
                                          globals.selectedHersteller;
                                      log('Lieferant: ' +
                                          globals.selectedHersteller!);
                                    });
                                  },
                                  items: globals.herstellerListe,
                                ),
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
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  hint: const Text(
                                    '- Artikeltyp auswählen -',
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
                                      ? "Wählen Sie bitte einen Artikeltyp aus!"
                                      : null,
                                  dropdownColor: Colors.white,
                                  value: globals.selectedArtikeltyp,
                                  onSaved: (value) =>
                                      globals.selectedArtikeltyp,
                                  onChanged: (artikeltyp) {
                                    if (artikeltyp == 'Fliesen') {
                                      globals.kategorien =
                                          globals.fliesenKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Parkett') {
                                      globals.kategorien =
                                          globals.parkettKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Garten') {
                                      globals.kategorien =
                                          globals.gartenKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Profile') {
                                      globals.kategorien =
                                          globals.profileKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Beläge') {
                                      globals.kategorien =
                                          globals.belaegeKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Chemie') {
                                      globals.kategorien =
                                          globals.chemieKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Naturbaustoffe') {
                                      globals.kategorien =
                                          globals.naturbaustoffeKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Holz') {
                                      globals.kategorien =
                                          globals.holzKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Bau') {
                                      globals.kategorien = globals.bauKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Unterlagen') {
                                      globals.kategorien =
                                          globals.unterlagenKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Sockelleisten') {
                                      globals.kategorien =
                                          globals.sockelleistenKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Stein') {
                                      globals.kategorien =
                                          globals.keineKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp ==
                                        'Werkzeuge und Zubehör') {
                                      globals.kategorien =
                                          globals.werkzeugeZubehoerKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Schreinerei') {
                                      globals.kategorien =
                                          globals.keineKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Glaserei') {
                                      globals.kategorien =
                                          globals.keineKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Metallbau') {
                                      globals.kategorien =
                                          globals.keineKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == null) {
                                      setState(() {
                                        List<String> glob;
                                        globals.kategorien = [];
                                        clearArtikeltyp();
                                        glob = globals.kategorien;
                                        log('LogELSE: $glob');
                                      });
                                    } else {
                                      setState(() {
                                        List<String> glob;
                                        globals.kategorien = [];
                                        clearArtikeltyp();
                                        glob = globals.kategorien;
                                        log('LogELSE: $glob');
                                      });
                                    }
                                    setState(() {
                                      globals.selectedKategorie = null;
                                      globals.selectedMaterial = null;
                                      globals.selectedArtikeltyp =
                                          artikeltyp! as String?;

                                      localArtikeltyp =
                                          globals.selectedArtikeltyp;
                                      log('Artikeltyp: ' +
                                          globals.selectedArtikeltyp!);
                                    });
                                  },
                                  items: globals.artTypen.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
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
                                  icon: const Icon(Icons.keyboard_arrow_down),
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
                                  onSaved: (value) => globals.selectedKategorie,
                                  onChanged: (kategorie) {
                                    if (kategorie == 'Massivparkett') {
                                      globals.materialien =
                                          globals.massivparkettMaterial;
                                    } else if (kategorie == 'Fertigparkett') {
                                      globals.materialien =
                                          globals.fertigparkettMaterial;
                                    } else if (kategorie ==
                                        'Massivholzdielen') {
                                      globals.materialien =
                                          globals.massivholzdielenMaterial;
                                    } else if (kategorie == 'Holzarten') {
                                      globals.materialien =
                                          globals.holzartenMaterial;
                                    } else if (kategorie == 'Terassendielen') {
                                      globals.materialien =
                                          globals.terassendielenMaterial;
                                    } else if (kategorie == 'Terassenplatten') {
                                      globals.materialien =
                                          globals.terassenplattenMaterial;
                                    } else if (kategorie == 'Möbel') {
                                      globals.materialien =
                                          globals.moebelMaterial;
                                    } else if (kategorie == 'Bodenbeläge') {
                                      globals.materialien =
                                          globals.bodenbelaegeMaterial;
                                    } else if (kategorie == 'Fliesen') {
                                      globals.materialien =
                                          globals.fliesenProfileMaterial;
                                    } else if (kategorie == 'Treppen') {
                                      globals.materialien =
                                          globals.treppenMaterial;
                                    } else if (kategorie == 'Feinsteinzeug') {
                                      globals.materialien =
                                          globals.fliesenMaterial;
                                    } else if (kategorie == 'Steinzeug') {
                                      globals.materialien =
                                          globals.fliesenMaterial;
                                    } else if (kategorie == 'Naturstein') {
                                      globals.materialien =
                                          globals.fliesenMaterial;
                                    } else if (kategorie ==
                                        'Elastische Beläge') {
                                      globals.materialien =
                                          globals.elastischeBelaegeMaterial;
                                    } else if (kategorie == 'Laminatboden') {
                                      globals.materialien =
                                          globals.laminatbodenMaterial;
                                    } else if (kategorie == 'Textile Beläge') {
                                      globals.materialien =
                                          globals.textileBelaegeMaterial;
                                    } else if (kategorie == 'Untergrund') {
                                      globals.materialien =
                                          globals.untergrundMaterial;
                                    } else if (kategorie == 'Klebstoffe') {
                                      globals.materialien =
                                          globals.klebstoffeMaterial;
                                    } else if (kategorie == 'Dichtstoffe') {
                                      globals.materialien =
                                          globals.dichtstoffeMaterial;
                                    } else if (kategorie ==
                                        'Verbundabdichtung') {
                                      globals.materialien =
                                          globals.verbundabdichtungMaterial;
                                    } else if (kategorie ==
                                        'Reinigungs- und Pflegemittel') {
                                      globals.materialien =
                                          globals.chemieMaterial;
                                    } else if (kategorie == 'Parkettlacke') {
                                      globals.materialien =
                                          globals.chemieMaterial;
                                    } else if (kategorie == 'Lackspray') {
                                      globals.materialien =
                                          globals.chemieMaterial;
                                    } else if (kategorie == 'Innenfarbe') {
                                      globals.materialien =
                                          globals.innenfarbeMaterial;
                                    } else if (kategorie == 'Putze') {
                                      globals.materialien =
                                          globals.putzeNaturbaustoffeMaterial;
                                    } else if (kategorie == 'Parkettöle') {
                                      globals.materialien =
                                          globals.naturbaustoffeMaterial;
                                    } else if (kategorie == 'Holzlasur') {
                                      globals.materialien =
                                          globals.naturbaustoffeMaterial;
                                    } else if (kategorie == 'Holzschutzfarbe') {
                                      globals.materialien =
                                          globals.naturbaustoffeMaterial;
                                    } else if (kategorie == 'Pflegemittel') {
                                      globals.materialien =
                                          globals.naturbaustoffeMaterial;
                                    } else if (kategorie == 'Dämmstoffe') {
                                      globals.materialien =
                                          globals.daemmstoffeMaterial;
                                    } else if (kategorie == 'Schnittholz') {
                                      globals.materialien =
                                          globals.holzMaterial;
                                    } else if (kategorie == 'Hobelware') {
                                      globals.materialien =
                                          globals.holzMaterial;
                                    } else if (kategorie ==
                                        'Plattenwerkstoffe') {
                                      globals.materialien =
                                          globals.plattenwerkstoffeMaterial;
                                    } else if (kategorie == 'Mörtel') {
                                      globals.materialien = globals.bauMaterial;
                                    } else if (kategorie == 'Putze') {
                                      globals.materialien = globals.bauMaterial;
                                    } else if (kategorie == 'Dämmschüttung') {
                                      globals.materialien = globals.bauMaterial;
                                    } else if (kategorie == 'Isolierung') {
                                      globals.materialien = globals.bauMaterial;
                                    } else if (kategorie == 'Estrich') {
                                      globals.materialien = globals.bauMaterial;
                                    } else if (kategorie == 'Dämmung') {
                                      globals.materialien =
                                          globals.unterlagenMaterial;
                                    } else if (kategorie == 'Entkopplung') {
                                      globals.materialien =
                                          globals.unterlagenMaterial;
                                    } else if (kategorie == 'Abdichtung') {
                                      globals.materialien =
                                          globals.unterlagenMaterial;
                                    } else if (kategorie == 'Holz massiv') {
                                      globals.materialien =
                                          globals.sockelleistenMaterial;
                                    } else if (kategorie == 'Holz furniert') {
                                      globals.materialien =
                                          globals.sockelleistenMaterial;
                                    } else if (kategorie == 'Holz ummantelt') {
                                      globals.materialien =
                                          globals.sockelleistenMaterial;
                                    } else if (kategorie == 'Metall') {
                                      globals.materialien =
                                          globals.sockelleistenMaterial;
                                    } else if (kategorie == 'Kunststoff') {
                                      globals.materialien =
                                          globals.sockelleistenMaterial;
                                    } else if (kategorie ==
                                        'Pinsel & Bürsten') {
                                      globals.materialien =
                                          globals.werkzeugeZubehoerMaterial;
                                    } else if (kategorie == 'Farbwalzen') {
                                      globals.materialien =
                                          globals.werkzeugeZubehoerMaterial;
                                    } else if (kategorie == 'Klebebänder') {
                                      globals.materialien =
                                          globals.werkzeugeZubehoerMaterial;
                                    } else if (kategorie == 'Abdeckmaterial') {
                                      globals.materialien =
                                          globals.werkzeugeZubehoerMaterial;
                                    } else if (kategorie == 'Schleifmittel') {
                                      globals.materialien =
                                          globals.werkzeugeZubehoerMaterial;
                                    } else if (kategorie ==
                                        'Keine Kategorie definiert') {
                                      globals.materialien =
                                          globals.keinMaterial;
                                    } else if (kategorie == null) {
                                      setState(() {
                                        List<String> glob;
                                        globals.materialien = [];
                                        glob = globals.materialien;
                                        log('LogELSE: $glob');
                                      });
                                    } else {
                                      setState(() {
                                        List<String> glob;
                                        globals.materialien = [];
                                        glob = globals.materialien;
                                        log('LogELSE: $glob');
                                      });
                                    }
                                    setState(() {
                                      globals.selectedMaterial = null;
                                      globals.selectedKategorie =
                                          kategorie! as String?;

                                      localKategorie =
                                          globals.selectedKategorie;
                                      log('Kategorie: ' +
                                          globals.selectedKategorie!);
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
                          const SizedBox(
                            height: 8.0,
                          ),
                          //Artikelnummer Lieferant
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Artikelnummer Lieferant*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: artNrLieferantController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    LengthLimitingTextInputFormatter(20),
                                  ],
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration: buildInputDecorationImage(
                                      'Artikelnummer eingeben',
                                      const AssetImage("assets/barcode.png")),
                                  onSaved: (value) => _artNrLieferant = value!,
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
                          /*
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
                                  controller: artNrInternController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    LengthLimitingTextInputFormatter(20),
                                  ],
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration: buildInputDecorationImage(
                                    'Artikelnummer eingeben',
                                    const AssetImage("assets/barcode.png"),
                                  ),
                                  onSaved: (value) => _artNrIntern = value!,
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
                           */
                          //EAN Barcode
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'EAN-Code*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: eanBarcodeController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    LengthLimitingTextInputFormatter(13),
                                  ],
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration: buildInputDecorationImage(
                                      'EAN-Code eingeben',
                                      const AssetImage("assets/barcode.png")),
                                  onSaved: (value) => _eanBarcode = value!,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Bitte geben Sie einen EAN-Code ein';
                                    } else if (value.length < 8) {
                                      return 'Der EAN-Code muss mindestens 8 Ziffern enthalten';
                                    } else if (value.length > 8 &&
                                        value.length < 13) {
                                      return 'Der EAN-Code darf nur 8 oder 13 Ziffern enthalten';
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
                          //Material
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Material*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                DropdownButtonFormField(
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  hint: const Text(
                                    '- Material auswählen -',
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
                                      ? "Wählen Sie bitte ein Material aus!"
                                      : null,
                                  dropdownColor: Colors.white,
                                  value: globals.selectedMaterial,
                                  onSaved: (value) => globals.selectedMaterial,
                                  onChanged: (material) {
                                    setState(() {
                                      globals.selectedMaterial =
                                          material as String?;
                                      localMaterial = globals.selectedMaterial;
                                    });
                                  },
                                  items:
                                      globals.materialien.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          //Dimension
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Dimension*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: dimensionController,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration: buildInputDecoration(
                                      'Dimension eingeben'),
                                  onSaved: (value) => _dimension = value!,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Bitte geben Sie die Dimension ein';
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
                          //Haptik
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Haptik*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: haptikController,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration:
                                      buildInputDecoration('Haptik eingeben'),
                                  onSaved: (value) => _haptik = value!,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Bitte geben Sie die Haptik ein';
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
                          //Optik
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Optik*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: optikController,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration:
                                      buildInputDecoration('Optik eingeben'),
                                  onSaved: (value) => _optik = value!,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Bitte geben Sie die Optik ein';
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
                          Text(response),
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

  InputDecoration buildInputDecorationDropdown() {
    return InputDecoration(
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
    );
  }

  InputDecoration buildInputDecorationIcon(String hint, IconData icon) {
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

  InputDecoration buildInputDecoration(String hint) {
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
    );
  }

  InputDecoration buildInputDecorationImage(String hint, AssetImage icon) {
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
              setState(() {
                localHersteller = globals.selectedHersteller;
                localArtikeltyp = globals.selectedArtikeltyp;
                localKategorie = globals.selectedKategorie;
                _artNrLieferant = artNrLieferantController.text;
                //_artNrIntern = artNrInternController.text;
                _eanBarcode = eanBarcodeController.text;
                localMaterial = globals.selectedMaterial;
                _dimension = dimensionController.text;
                _haptik = haptikController.text;
                _optik = optikController.text;

                log('Lieferant: $localHersteller');
                log('Artikeltyp: $localArtikeltyp');
                log('Kategorie: $localKategorie');
                log('Artikelnummer_Lieferant: $_artNrLieferant');
                //log('Artikelnummer_Intern: $_artNrIntern');
                log('EAN Barcodenummer: $_eanBarcode');
                log('Material: $localMaterial');
                log('Dimension: $_dimension');
                log('Haptik: $_haptik');
                log('Optik: $_optik');

                artNrLieferantController.clear();
                //artNrInternController.clear();
                eanBarcodeController.clear();
                dimensionController.clear();
                haptikController.clear();
                optikController.clear();

                globals.selectedHersteller = null;
                globals.selectedArtikeltyp = null;
                globals.selectedKategorie = null;
                globals.selectedMaterial = null;
              });
              _uploadImage();

              AddartikelRequestModel model = AddartikelRequestModel(
                lieferant: localHersteller,
                artikeltyp: localArtikeltyp,
                kategorie: localKategorie,
                artnrlieferant: _artNrLieferant,
                eancode: _eanBarcode,
                material: localMaterial,
                dimension: _dimension,
                haptik: _haptik,
                optik: _optik,
                //image: _uploadImage(),
                //image: imagePath,
                image: imageName,
                //image: imagePath.toString(),
              );

              APIService.addartikel(model).then(
                (response) {
                  setState(() {
                    //isApiCallProcess = false;
                  });

                  if (response.data != null && image != null) {
                    log("Bild wurde hochgeladen");

                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Center(
                                  child: Text(
                                Config.appName,
                                style: TextStyle(color: Color(0xFFF76A25)),
                              )),
                              content: const Text(
                                  'Der Artikel wurde erfolgreich angelegt'),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: GestureDetector(
                                        child: const Text("OK"),
                                        onTap: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ),
                              ],
                            ));
                  } else if (image == null) {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Center(
                                  child: Text(
                                Config.appName,
                                style: TextStyle(color: Color(0xFFF76A25)),
                              )),
                              content: const Text(
                                  'Der Artikel wurde ohne Bild hochgeladen, da keines ausgewählt/aufgenommen wurde'),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: GestureDetector(
                                        child: const Text("OK"),
                                        onTap: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ),
                              ],
                            ));
                  } else {
                    log("Bild hochladen fehlgeschlagen");
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Center(
                                  child: Text(
                                Config.appName,
                                style: TextStyle(color: Color(0xFFF76A25)),
                              )),
                              content: Text(response.message),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: GestureDetector(
                                        child: const Text("OK"),
                                        onTap: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ),
                              ],
                            ));
                  }
                },
              );
            }
          }),
    );
  }

  Future<String?> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('picture', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }

  Future uploadData(imageFilePath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    /*await http.MultipartFile.fromPath('image', imageFilePath,
        filename: 'image_$name.jpg');*/

    request.files
        .add(await http.MultipartFile.fromPath('image', imageFilePath));

    //request.files.add(new http.MultipartFile.fromBytes('file', await File.fromUri("<path/to/file>").readAsBytes(), contentType: new MediaType('image', 'jpeg')))
    /*
    request.files.add(http.MultipartFile.fromBytes(
        'image', await File.fromUri(Uri.parse(imagePath)).readAsBytes(),
        filename: 'image_$name.jpg',
        contentType: new MediaType('image', 'jpeg')));
    */

    request.fields['companyName'] = name;
    request.fields['own_id'] = id;

    var res = await request.send();

    return res.statusCode;
  }

  _uploadImage() async {
    imageName = image?.path.split('/').last;
    //String? fileName = image?.path.split('/').last;

    Map<String, String> _headers = <String, String>{
      //'Content-Type': 'multipart/form-data',
      'Content-Type': 'application/json, multipart/form-data',
      'Accept': 'application/json',
    };
    var formData = FormData.fromMap(
      {
        "image": await MultipartFile.fromFile(
          image!.path,
          filename: imageName,
          //filename: fileName,
          contentType: MediaType("image", "jpeg"),
        ),
      },
    );
    Map<String, String> headers = <String, String>{
      'Content-Type': 'multipart/form-data'
    };
    //_headers['access_token'] = ;
    //var response = await Dio().post("http://localhost:4000/upload", data: formData);
    //ONLINE HEROKU
    var response = await Dio().post("http://artenativ.herokuapp.com/upload",
        data: formData, options: Options(headers: _headers));
    /**
    //OFFICE LOCAL IMAGE UPLOAD
    var response = await Dio().post("http://192.168.188.85:4000/upload",
        data: formData, options: Options(headers: _headers));
    */
    //var response = await Dio().post("http://192.168.188.85:4000/artikel/addartikel", data: formData);
    //var response = await Dio().post(Uri.http(Config.apiURL, Config.addartikelAPI).toString(), data: formData);
    //var response = await Dio().post("http://192.168.178.37:4000/upload", data: formData);
    debugPrint(response.toString());
  }

  Widget getListView(BuildContext context) {
    Future pickImage(ImageSource source) async {
      try {
        final image = await ImagePicker().pickImage(source: source);
        if (image == null) return;
        final imageTemporary = File(image.path);
        //setState(() => this.image = imageTemporary);
        setState(() {
          this.image = imageTemporary;
          imagePath = imageTemporary;
        });
      } on PlatformException catch (e) {
        if (kDebugMode) {
          print('Bild auswählen fehlgeschlagen: $e');
        }
      }
    }

    var listView = Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
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

void clearHersteller() {
  globals.kategorien = [];
  globals.materialien = [];
}

void clearArtikeltyp() {
  globals.materialien = [];
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
        icon: const Icon(Icons.keyboard_arrow_down),
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
