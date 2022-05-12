import 'dart:developer';
import 'dart:async';
import 'dart:io';
import 'package:artenativ/components/barcodescanner.dart';
import 'package:artenativ/finditem.dart';
import 'package:artenativ/config.dart';
import 'package:artenativ/models/addartikel_request_model.dart';
import 'package:artenativ/models/artikel_request.dart';
import 'package:artenativ/services/api_service.dart';
import 'package:artenativ/testfile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:artenativ/globals.dart';
//import 'globals.dart' as globals;
import 'package:artenativ/home.dart';
import 'package:artenativ/login.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'components/qrscanner.dart';

class AddItemsScreen extends StatefulWidget {
  const AddItemsScreen({Key? key}) : super(key: key);

  @override
  _AddItemsScreenState createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  String? imageName;
  File? image;
  var imageContainer;

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
  String? lieferantandartikelnummer;

  //Variables for Textfields Content
  String? _artNrLieferant = '';
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

  @override
  void initState() {
    getInternID();
    log("Global Init Intern ID: $artNrIntern");
    //localHersteller = globals.selectedHersteller;
    localHersteller = selectedHersteller;
    localArtikeltyp = selectedArtikeltyp;
    localKategorie = selectedKategorie;
    _artNrLieferant = artNrLieferantController.text;
    _eanBarcode = eanBarcodeController.text;
    eanCodeGlobal;
    if (barcodeResult != null) {
      _eanBarcode = barcodeResult;
      eanCodeGlobal = barcodeResult!;
    }
    localMaterial = selectedMaterial;
    _dimension = dimensionController.text;
    _haptik = haptikController.text;
    _optik = optikController.text;
    super.initState();
    image = null;
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
    eanCodeGlobal = '';
    barcodeResult = null;
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
                                  value: selectedHersteller,
                                  onSaved: (value) => selectedHersteller,
                                  onChanged: (hersteller) {
                                    if (hersteller == 'Admonter') {
                                      artTypen = admonter;
                                      clearHersteller();
                                    } else if (hersteller == 'Alu Plan') {
                                      artTypen = aluPlan;
                                      clearHersteller();
                                    } else if (hersteller == 'Amorim') {
                                      artTypen = amorim;
                                      clearHersteller();
                                    } else if (hersteller == 'Amtico') {
                                      artTypen = amtico;
                                      clearHersteller();
                                    } else if (hersteller == 'Artenativ') {
                                      artTypen = all;
                                      clearHersteller();
                                    } else if (hersteller == 'Bauwerk') {
                                      artTypen = bauwerk;
                                      clearHersteller();
                                    } else if (hersteller == 'Bärwolf') {
                                      artTypen = baerwolf;
                                      clearHersteller();
                                    } else if (hersteller ==
                                        'Becker Großgarten') {
                                      artTypen = becker;
                                      clearHersteller();
                                    } else if (hersteller == 'Belopa') {
                                      artTypen = belopa;
                                      clearHersteller();
                                    } else if (hersteller == 'Biehler') {
                                      artTypen = biehler;
                                      clearHersteller();
                                    } else if (hersteller == 'Brich') {
                                      artTypen = brich;
                                      clearHersteller();
                                    } else if (hersteller == 'BTI') {
                                      artTypen = bti;
                                      clearHersteller();
                                    } else if (hersteller == 'Buchner') {
                                      artTypen = buchner;
                                      clearHersteller();
                                    } else if (hersteller ==
                                        'Burger Holzzentrum') {
                                      artTypen = burgerHolz;
                                      clearHersteller();
                                    } else if (hersteller == 'Christ') {
                                      artTypen = christ;
                                      clearHersteller();
                                    } else if (hersteller == 'Climacell') {
                                      artTypen = climacell;
                                      clearHersteller();
                                    } else if (hersteller == 'Dahm') {
                                      artTypen = dahm;
                                      clearHersteller();
                                    } else if (hersteller == 'Denzel') {
                                      artTypen = denzel;
                                      clearHersteller();
                                    } else if (hersteller == 'Desso') {
                                      artTypen = desso;
                                      clearHersteller();
                                    } else if (hersteller == 'Dekora') {
                                      artTypen = dekora;
                                      clearHersteller();
                                    } else if (hersteller == 'Döllken') {
                                      artTypen = doellken;
                                      clearHersteller();
                                    } else if (hersteller == 'Dr. Schutz') {
                                      artTypen = schutz;
                                      clearHersteller();
                                    } else if (hersteller == 'Dura') {
                                      artTypen = dura;
                                      clearHersteller();
                                    } else if (hersteller == 'Dural') {
                                      artTypen = dural;
                                      clearHersteller();
                                    } else if (hersteller ==
                                        'Effektiv Werkzeug') {
                                      artTypen = effektivWerkzeug;
                                      clearHersteller();
                                    } else if (hersteller == 'Enia') {
                                      artTypen = enia;
                                      clearHersteller();
                                    } else if (hersteller == 'Ewifoam') {
                                      artTypen = ewifoam;
                                      clearHersteller();
                                    } else if (hersteller == 'Fabromont') {
                                      artTypen = fabromont;
                                      clearHersteller();
                                    } else if (hersteller == 'Fetim') {
                                      artTypen = fetim;
                                      clearHersteller();
                                    } else if (hersteller ==
                                        'Fulda Filzfabrik') {
                                      artTypen = fuldaFilzfabrik;
                                      clearHersteller();
                                    } else if (hersteller == 'Futura Floors') {
                                      artTypen = futuraFloors;
                                      clearHersteller();
                                    } else if (hersteller == 'Floors 4ever') {
                                      artTypen = floorsEver;
                                      clearHersteller();
                                    } else if (hersteller == 'Forbo Eurocool') {
                                      artTypen = forboEurocool;
                                      clearHersteller();
                                    } else if (hersteller == 'Forbo Flooring') {
                                      artTypen = forboFlooring;
                                      clearHersteller();
                                    } else if (hersteller == 'Gerflor') {
                                      artTypen = gerflor;
                                      clearHersteller();
                                    } else if (hersteller == 'Götz Carl') {
                                      artTypen = gotzCarl;
                                      clearHersteller();
                                    } else if (hersteller == 'Gunreben') {
                                      artTypen = gunreben;
                                      clearHersteller();
                                    } else if (hersteller == 'GW Tischler') {
                                      artTypen = gwTischler;
                                      clearHersteller();
                                    } else if (hersteller == 'Harrer') {
                                      artTypen = harrer;
                                      clearHersteller();
                                    } else if (hersteller == 'Hasit') {
                                      artTypen = hasit;
                                      clearHersteller();
                                    } else if (hersteller == 'Hocotimber') {
                                      artTypen = hocotimber;
                                      clearHersteller();
                                    } else if (hersteller == 'Hanke') {
                                      artTypen = hanke;
                                      clearHersteller();
                                    } else if (hersteller == 'Intercell') {
                                      artTypen = intercell;
                                      clearHersteller();
                                    } else if (hersteller == 'Janser') {
                                      artTypen = janser;
                                      clearHersteller();
                                    } else if (hersteller == 'Jasba') {
                                      artTypen = jasba;
                                      clearHersteller();
                                    } else if (hersteller == 'Jäger') {
                                      artTypen = jaeger;
                                      clearHersteller();
                                    } else if (hersteller == 'JEP') {
                                      artTypen = jep;
                                      clearHersteller();
                                    } else if (hersteller == 'Jordan') {
                                      artTypen = jordan;
                                      clearHersteller();
                                    } else if (hersteller == 'Keskin') {
                                      artTypen = keskin;
                                      clearHersteller();
                                    } else if (hersteller == 'KGM') {
                                      artTypen = kgm;
                                      clearHersteller();
                                    } else if (hersteller == 'KLB') {
                                      artTypen = klb;
                                      clearHersteller();
                                    } else if (hersteller == 'Koeber') {
                                      artTypen = koeber;
                                      clearHersteller();
                                    } else if (hersteller == 'Küblböck') {
                                      artTypen = kueblboeck;
                                      clearHersteller();
                                    } else if (hersteller == 'KWG') {
                                      artTypen = kwg;
                                      clearHersteller();
                                    } else if (hersteller == 'Martin Meier') {
                                      artTypen = martinMeier;
                                      clearHersteller();
                                    } else if (hersteller == 'Mayer Bauz') {
                                      artTypen = mayerBauz;
                                      clearHersteller();
                                    } else if (hersteller == 'Murexin') {
                                      artTypen = murexin;
                                      clearHersteller();
                                    } else if (hersteller == 'NBO') {
                                      artTypen = nbo;
                                      clearHersteller();
                                    } else if (hersteller == 'Neuhofer') {
                                      artTypen = neuhofer;
                                      clearHersteller();
                                    } else if (hersteller == 'Norwork') {
                                      artTypen = norwork;
                                      clearHersteller();
                                    } else if (hersteller == 'Meister Werke') {
                                      artTypen = meisterWerke;
                                      clearHersteller();
                                    } else if (hersteller == 'Objectflor') {
                                      artTypen = objectflor;
                                      clearHersteller();
                                    } else if (hersteller == 'Ochs') {
                                      artTypen = ochs;
                                      clearHersteller();
                                    } else if (hersteller == 'Oster') {
                                      artTypen = oster;
                                      clearHersteller();
                                    } else if (hersteller == 'Otto Chemie') {
                                      artTypen = ottoChemie;
                                      clearHersteller();
                                    } else if (hersteller == 'Pallmann') {
                                      artTypen = pallmann;
                                      clearHersteller();
                                    } else if (hersteller == 'Parigiani') {
                                      artTypen = parigiani;
                                      clearHersteller();
                                    } else if (hersteller == 'Scheffold') {
                                      artTypen = scheffold;
                                      clearHersteller();
                                    } else if (hersteller == 'Solum') {
                                      artTypen = solum;
                                      clearHersteller();
                                    } else if (hersteller == 'Pfahler') {
                                      artTypen = pfahler;
                                      clearHersteller();
                                    } else if (hersteller == 'PNZ') {
                                      artTypen = pnz;
                                      clearHersteller();
                                    } else if (hersteller == 'Prinz Carl') {
                                      artTypen = prinzCarl;
                                      clearHersteller();
                                    } else if (hersteller == 'Project Floors') {
                                      artTypen = projectFloors;
                                      clearHersteller();
                                    } else if (hersteller == 'Raab Karcher') {
                                      artTypen = raabKarcher;
                                      clearHersteller();
                                    } else if (hersteller == 'Reincke') {
                                      artTypen = reincke;
                                      clearHersteller();
                                    } else if (hersteller == 'Repack') {
                                      artTypen = repack;
                                      clearHersteller();
                                    } else if (hersteller == 'Sonat') {
                                      artTypen = sonat;
                                      clearHersteller();
                                    } else if (hersteller == 'Sonnenpartner') {
                                      artTypen = sonnenpartner;
                                      clearHersteller();
                                    } else if (hersteller == 'Schimmer') {
                                      artTypen = schimmer;
                                      clearHersteller();
                                    } else if (hersteller == 'Schlau') {
                                      artTypen = schlau;
                                      clearHersteller();
                                    } else if (hersteller == 'Schlingelhoff') {
                                      artTypen = schlingelhoff;
                                      clearHersteller();
                                    } else if (hersteller == 'Schmitt B') {
                                      artTypen = schmittB;
                                      clearHersteller();
                                    } else if (hersteller == 'Schuhböcks') {
                                      artTypen = schuhboecks;
                                      clearHersteller();
                                    } else if (hersteller == 'Schuller') {
                                      artTypen = schuller;
                                      clearHersteller();
                                    } else if (hersteller == 'Stauf') {
                                      artTypen = stauf;
                                      clearHersteller();
                                    } else if (hersteller == 'Tagia') {
                                      artTypen = tagia;
                                      clearHersteller();
                                    } else if (hersteller == 'Tapes Tools') {
                                      artTypen = tapesTools;
                                      clearHersteller();
                                    } else if (hersteller == 'Taxis') {
                                      artTypen = taxis;
                                      clearHersteller();
                                    } else if (hersteller == 'TFD') {
                                      artTypen = tfd;
                                      clearHersteller();
                                    } else if (hersteller == 'Thede Witte') {
                                      artTypen = thedeWitte;
                                      clearHersteller();
                                    } else if (hersteller == 'Templer') {
                                      artTypen = templer;
                                      clearHersteller();
                                    } else if (hersteller == 'Thalhofer') {
                                      artTypen = thalhofer;
                                      clearHersteller();
                                    } else if (hersteller == 'Upofloor') {
                                      artTypen = upofloor;
                                      clearHersteller();
                                    } else if (hersteller == 'Vorwerk') {
                                      artTypen = vorwerk;
                                      clearHersteller();
                                    } else if (hersteller == 'Wakol') {
                                      artTypen = wakol;
                                      clearHersteller();
                                    } else if (hersteller == 'Weitzer') {
                                      artTypen = weitzer;
                                      clearHersteller();
                                    } else if (hersteller == 'Windmöller') {
                                      artTypen = windmoeller;
                                      clearHersteller();
                                    } else if (hersteller == 'Würth') {
                                      artTypen = wuerth;
                                      clearHersteller();
                                    } else if (hersteller == 'ZEG') {
                                      artTypen = zeg;
                                      clearHersteller();
                                    } else if (hersteller == null) {
                                      setState(() {
                                        List<String> artTyp;
                                        artTypen = [];
                                        artTyp = artTypen;
                                        log('LogELSE: $artTyp');
                                        List<String> kategorie;
                                        kategorien = [];
                                        kategorie = kategorien;
                                        log('LogELSE: $kategorie');
                                        List<String> material;
                                        materialien = [];
                                        material = materialien;
                                        log('LogELSE: $material');
                                      });
                                    } else {
                                      setState(() {
                                        List<String> artTyp;
                                        artTypen = [];
                                        artTyp = artTypen;
                                        log('LogELSE: $artTyp');
                                        List<String> kategorie;
                                        kategorien = [];
                                        kategorie = kategorien;
                                        log('LogELSE: $kategorie');
                                        List<String> material;
                                        materialien = [];
                                        material = materialien;
                                        log('LogELSE: $material');
                                      });
                                    }
                                    setState(() {
                                      selectedArtikeltyp = null;
                                      selectedKategorie = null;
                                      selectedMaterial = null;
                                      selectedHersteller =
                                          hersteller! as String?;

                                      localHersteller = selectedHersteller;
                                      log('Lieferant: ' + selectedHersteller!);
                                    });
                                  },
                                  items: herstellerListe,
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
                                  value: selectedArtikeltyp,
                                  onSaved: (value) => selectedArtikeltyp,
                                  onChanged: (artikeltyp) {
                                    if (artikeltyp == 'Fliesen') {
                                      kategorien = fliesenKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Parkett') {
                                      kategorien = parkettKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Garten') {
                                      kategorien = gartenKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Profile') {
                                      kategorien = profileKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Beläge') {
                                      kategorien = belaegeKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Chemie') {
                                      kategorien = chemieKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Naturbaustoffe') {
                                      kategorien = naturbaustoffeKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Holz') {
                                      kategorien = holzKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Bau') {
                                      kategorien = bauKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Unterlagen') {
                                      kategorien = unterlagenKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Sockelleisten') {
                                      kategorien = sockelleistenKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Stein') {
                                      kategorien = keineKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp ==
                                        'Werkzeuge und Zubehör') {
                                      kategorien = werkzeugeZubehoerKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Schreinerei') {
                                      kategorien = keineKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Glaserei') {
                                      kategorien = keineKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == 'Metallbau') {
                                      kategorien = keineKategorie;
                                      clearArtikeltyp();
                                    } else if (artikeltyp == null) {
                                      setState(() {
                                        List<String> glob;
                                        kategorien = [];
                                        clearArtikeltyp();
                                        glob = kategorien;
                                        log('LogELSE: $glob');
                                      });
                                    } else {
                                      setState(() {
                                        List<String> glob;
                                        kategorien = [];
                                        clearArtikeltyp();
                                        glob = kategorien;
                                        log('LogELSE: $glob');
                                      });
                                    }
                                    setState(() {
                                      selectedKategorie = null;
                                      selectedMaterial = null;
                                      selectedArtikeltyp =
                                          artikeltyp! as String?;

                                      localArtikeltyp = selectedArtikeltyp;
                                      log('Artikeltyp: ' + selectedArtikeltyp!);
                                    });
                                  },
                                  items: artTypen.map((String value) {
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
                                  value: selectedKategorie,
                                  onSaved: (value) => selectedKategorie,
                                  onChanged: (kategorie) {
                                    if (kategorie == 'Massivparkett') {
                                      materialien = massivparkettMaterial;
                                    } else if (kategorie == 'Fertigparkett') {
                                      materialien = fertigparkettMaterial;
                                    } else if (kategorie ==
                                        'Massivholzdielen') {
                                      materialien = massivholzdielenMaterial;
                                    } else if (kategorie == 'Holzarten') {
                                      materialien = holzartenMaterial;
                                    } else if (kategorie == 'Terassendielen') {
                                      materialien = terassendielenMaterial;
                                    } else if (kategorie == 'Terassenplatten') {
                                      materialien = terassenplattenMaterial;
                                    } else if (kategorie == 'Möbel') {
                                      materialien = moebelMaterial;
                                    } else if (kategorie == 'Bodenbeläge') {
                                      materialien = bodenbelaegeMaterial;
                                    } else if (kategorie == 'Fliesen') {
                                      materialien = fliesenProfileMaterial;
                                    } else if (kategorie == 'Treppen') {
                                      materialien = treppenMaterial;
                                    } else if (kategorie == 'Feinsteinzeug') {
                                      materialien = fliesenMaterial;
                                    } else if (kategorie == 'Steinzeug') {
                                      materialien = fliesenMaterial;
                                    } else if (kategorie == 'Naturstein') {
                                      materialien = fliesenMaterial;
                                    } else if (kategorie ==
                                        'Elastische Beläge') {
                                      materialien = elastischeBelaegeMaterial;
                                    } else if (kategorie == 'Laminatboden') {
                                      materialien = laminatbodenMaterial;
                                    } else if (kategorie == 'Textile Beläge') {
                                      materialien = textileBelaegeMaterial;
                                    } else if (kategorie == 'Untergrund') {
                                      materialien = untergrundMaterial;
                                    } else if (kategorie == 'Klebstoffe') {
                                      materialien = klebstoffeMaterial;
                                    } else if (kategorie == 'Dichtstoffe') {
                                      materialien = dichtstoffeMaterial;
                                    } else if (kategorie ==
                                        'Verbundabdichtung') {
                                      materialien = verbundabdichtungMaterial;
                                    } else if (kategorie ==
                                        'Reinigungs- und Pflegemittel') {
                                      materialien = chemieMaterial;
                                    } else if (kategorie == 'Parkettlacke') {
                                      materialien = chemieMaterial;
                                    } else if (kategorie == 'Lackspray') {
                                      materialien = chemieMaterial;
                                    } else if (kategorie == 'Innenfarbe') {
                                      materialien = innenfarbeMaterial;
                                    } else if (kategorie == 'Putze') {
                                      materialien = putzeNaturbaustoffeMaterial;
                                    } else if (kategorie == 'Parkettöle') {
                                      materialien = naturbaustoffeMaterial;
                                    } else if (kategorie == 'Holzlasur') {
                                      materialien = naturbaustoffeMaterial;
                                    } else if (kategorie == 'Holzschutzfarbe') {
                                      materialien = naturbaustoffeMaterial;
                                    } else if (kategorie == 'Pflegemittel') {
                                      materialien = naturbaustoffeMaterial;
                                    } else if (kategorie == 'Dämmstoffe') {
                                      materialien = daemmstoffeMaterial;
                                    } else if (kategorie == 'Schnittholz') {
                                      materialien = holzMaterial;
                                    } else if (kategorie == 'Hobelware') {
                                      materialien = holzMaterial;
                                    } else if (kategorie ==
                                        'Plattenwerkstoffe') {
                                      materialien = plattenwerkstoffeMaterial;
                                    } else if (kategorie == 'Mörtel') {
                                      materialien = bauMaterial;
                                    } else if (kategorie == 'Putze') {
                                      materialien = bauMaterial;
                                    } else if (kategorie == 'Dämmschüttung') {
                                      materialien = bauMaterial;
                                    } else if (kategorie == 'Isolierung') {
                                      materialien = bauMaterial;
                                    } else if (kategorie == 'Estrich') {
                                      materialien = bauMaterial;
                                    } else if (kategorie == 'Dämmung') {
                                      materialien = unterlagenMaterial;
                                    } else if (kategorie == 'Entkopplung') {
                                      materialien = unterlagenMaterial;
                                    } else if (kategorie == 'Abdichtung') {
                                      materialien = unterlagenMaterial;
                                    } else if (kategorie == 'Holz massiv') {
                                      materialien = sockelleistenMaterial;
                                    } else if (kategorie == 'Holz furniert') {
                                      materialien = sockelleistenMaterial;
                                    } else if (kategorie == 'Holz ummantelt') {
                                      materialien = sockelleistenMaterial;
                                    } else if (kategorie == 'Metall') {
                                      materialien = sockelleistenMaterial;
                                    } else if (kategorie == 'Kunststoff') {
                                      materialien = sockelleistenMaterial;
                                    } else if (kategorie ==
                                        'Pinsel & Bürsten') {
                                      materialien = werkzeugeZubehoerMaterial;
                                    } else if (kategorie == 'Farbwalzen') {
                                      materialien = werkzeugeZubehoerMaterial;
                                    } else if (kategorie == 'Klebebänder') {
                                      materialien = werkzeugeZubehoerMaterial;
                                    } else if (kategorie == 'Abdeckmaterial') {
                                      materialien = werkzeugeZubehoerMaterial;
                                    } else if (kategorie == 'Schleifmittel') {
                                      materialien = werkzeugeZubehoerMaterial;
                                    } else if (kategorie ==
                                        'Keine Kategorie definiert') {
                                      materialien = keinMaterial;
                                    } else if (kategorie == null) {
                                      setState(() {
                                        List<String> glob;
                                        materialien = [];
                                        glob = materialien;
                                        log('LogELSE: $glob');
                                      });
                                    } else {
                                      setState(() {
                                        List<String> glob;
                                        materialien = [];
                                        glob = materialien;
                                        log('LogELSE: $glob');
                                      });
                                    }
                                    setState(() {
                                      selectedMaterial = null;
                                      selectedKategorie = kategorie! as String?;

                                      localKategorie = selectedKategorie;
                                      log('Kategorie: ' + selectedKategorie!);
                                    });
                                  },
                                  items: kategorien.map((String value) {
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
                                  //Only 8 Numbers Allowed
                                  /*
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    LengthLimitingTextInputFormatter(8),
                                  ],*/
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration: buildInputDecorationIcon(
                                      'Artikelnummer eingeben', Icons.numbers),
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
                                  controller: eanBarcodeController
                                    ..text = eanCodeGlobal,
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
                                  onChanged: (value) => eanCodeGlobal = value,
                                  onSaved: (value) => eanCodeGlobal = value!,
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
                                  value: selectedMaterial,
                                  onSaved: (value) => selectedMaterial,
                                  onChanged: (material) {
                                    setState(() {
                                      selectedMaterial = material as String?;
                                      localMaterial = selectedMaterial;
                                    });
                                  },
                                  items: materialien.map((String value) {
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
                          const SizedBox(
                            height: 20.0,
                          ), //getListView(context),
                          //TESTBUTTONS
                          /**const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 56.0,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFF1565C0),
                            ),
                            child: MaterialButton(
                                child: const Text(
                                  "TestButton",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.0,
                                  ),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    log('-------------------------------');
                                    log("Global Intern: $artNrIntern");
                                    log("Local InternString: $artNrInternString");

                                    APIService.getlastinternid();

                                    log("PRINT");

                                    log("New Global Intern: $artNrIntern");
                                    log("New Local InternString: $artNrInternString");

                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: const Center(
                                                  child: Text(
                                                'Hurra!',
                                                style: TextStyle(
                                                    color: Color(0xFF1565C0)),
                                              )),
                                              content:
                                                  const Text('Test Alert Text'),
                                              actions: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Container(
                                                      height: 36.0,
                                                      width: 80.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        color: const Color(
                                                            0xFF1565C0),
                                                      ),
                                                      child: MaterialButton(
                                                          child: const Text(
                                                            "OK",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ));
                                  });
                                }),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 56.0,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFF74D175),
                            ),
                            child: MaterialButton(
                                child: const Text(
                                  "QR Code",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.0,
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Stack(
                                                    children: [
                                                      QRScannerScreen(
                                                          overlayColour: Colors
                                                              .black
                                                              .withOpacity(
                                                                  0.5)),
                                                    ],
                                                  ),
                                              fullscreenDialog: true))
                                      .then((value) => setState(() {
                                            if (qrcodeResult != null) {
                                            } else {}
                                          }));
                                }),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 56.0,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFFFFD700),
                            ),
                            child: MaterialButton(
                                child: const Text(
                                  "Barcode",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.0,
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Stack(
                                                    children: [
                                                      BarcodeScannerScreen(
                                                          overlayColour: Colors
                                                              .black
                                                              .withOpacity(
                                                                  0.5)),
                                                    ],
                                                  ),
                                              fullscreenDialog: true))
                                      .then((value) => setState(() {
                                            if (barcodeResult != null) {
                                              eanCodeGlobal = barcodeResult!;
                                              _eanBarcode = barcodeResult;
                                            } else {
                                              eanCodeGlobal = '';
                                            }
                                          }));
                                }),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),*/
                          //Test Print Button
                          /**
                            Container(
                            height: 56.0,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFF9E1B32),
                            ),
                            child: MaterialButton(
                                child: const Text(
                                  "Printing",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.0,
                                  ),
                                ),
                                onPressed: () async {
                                  log("Button pressed");

                                  const PaperSize paper = PaperSize.mm80;
                                  final profile =
                                      await CapabilityProfile.load();
                                  final printer =
                                      NetworkPrinter(paper, profile);

                                  //POS Printer
                                  final PosPrintResult res = await printer
                                      .connect('192.168.188.115', port: 9500);

                                  //Office Printer
                                  //final PosPrintResult res = await printer.connect('192.168.188.71', port: 9100);

                                  if (res == PosPrintResult.success) {
                                    networkPrinter(printer);
                                    printer.disconnect();
                                  }

                                  print('Print result: ${res.msg}');
                                }),
                          ),*/
                          /**Container(
                            height: 56.0,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFF9E1B32),
                            ),
                            child: MaterialButton(
                                child: const Text(
                                  "Printing",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.0,
                                  ),
                                ),
                                onPressed: () async {
                                  log('PrinterIP: $printerIp');
                                  log('PrinterPort: $printerPort');
                                  _printLabel();
                                }),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 56.0,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFF364975),
                            ),
                            child: MaterialButton(
                                child: const Text(
                                  "Update",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.0,
                                  ),
                                ),
                                onPressed: () async {
                                  Artikel model = Artikel(
                                    lieferant: 'Admonter',
                                    artikeltyp: 'Parkett',
                                    kategorie: 'Holzarten',
                                    artnrlieferant: '987654321',
                                    lieferantandartikelnummer:
                                        'Admonter987654321',
                                    artnrintern: '10000006',
                                    eancode: '12345678',
                                    bezeichnung: 'Bezeichnung',
                                    material: 'Eiche',
                                    dimension: 'Dimension',
                                    haptik: 'Haptik',
                                    optik: 'Optik',
                                    sortierung: 'Sortierung',
                                    vpeeinzeln: 'test',
                                    einzelneinheit: 'Container',
                                    vpebund: 'test',
                                    bundeinheit: 'Container',
                                    eigenschaft: 'Eigenschaft',
                                    beanspruchungsklasse: '0',
                                    verfugbarkeit: 'Lager',
                                    einkaufspreis: '1',
                                    verkaufspreiseins: '2',
                                    verkaufspreiszwei: '3',
                                    verkaufspreisdrei: '4',
                                    ausstellplatz: 'test',
                                    //imageName: imageName,
                                  );

                                  APIService.updateartikel(
                                          model, model.artnrintern)
                                      .then(
                                    (response) {
                                      setState(() {
                                        //isApiCallProcess = false;
                                      });

                                      if (response.data != null &&
                                          image != null) {
                                        log("Bild wurde hochgeladen");
                                        log('Intern Bild: $artNrInternString');
                                        showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: const Center(
                                                      child: Text(
                                                    'Hurra!',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFF76A25)),
                                                  )),
                                                  content: const Text(
                                                      'Der Artikel wurde erfolgreich angelegt'),
                                                  actions: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Container(
                                                          height: 36.0,
                                                          width: 80.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            color: const Color(
                                                                0xFFF76A25),
                                                          ),
                                                          child: MaterialButton(
                                                              child: const Text(
                                                                "OK",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              }),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                      } else if (response.data != null &&
                                          image == null) {
                                        log('Intern ohne Bild: $artNrInternString');
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: const Center(
                                                      child: Text(
                                                    'Hurra, aber Achtung!',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFF76A25)),
                                                  )),
                                                  content: const Text(
                                                      'Der Artikel wurde ohne Bild hochgeladen, da keines ausgewählt/aufgenommen wurde'),
                                                  actions: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Container(
                                                          height: 36.0,
                                                          width: 80.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            color: const Color(
                                                                0xFFF76A25),
                                                          ),
                                                          child: MaterialButton(
                                                              child: const Text(
                                                                "OK",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              }),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                      } else {
                                        log("Bild hochladen fehlgeschlagen");
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: const Center(
                                                      child: Text(
                                                    'Oops, ein Fehler ist aufgetreten!',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFF76A25)),
                                                  )),
                                                  content:
                                                      Text(response.message),
                                                  actions: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Container(
                                                          height: 36.0,
                                                          width: 80.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            color: const Color(
                                                                0xFFF76A25),
                                                          ),
                                                          child: MaterialButton(
                                                              child: const Text(
                                                                "OK",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              }),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                      }
                                    },
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 56.0,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFF9E1B32),
                            ),
                            child: MaterialButton(
                                child: const Text(
                                  "FindItem",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.0,
                                  ),
                                ),
                                onPressed: () async {
                                  int testint = 10000009;
                                  APIService.findartikel(testint).then(
                                    (response) {
                                      setState(() {
                                        //isApiCallProcess = false;
                                      });

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FindItemScreen()));
                                    },
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 56.0,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFF9E1B32),
                            ),
                            child: MaterialButton(
                                child: const Text(
                                  "GETARTIKEL",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.0,
                                  ),
                                ),
                                onPressed: () async {
                                  int testint = 10000000;
                                  APIService.findartikel(testint).then(
                                    (response) {
                                      setState(() {
                                        //isApiCallProcess = false;
                                      });

                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: const Center(
                                                    child: Text(
                                                  Config.appName,
                                                  style: TextStyle(
                                                      color: Color(0xFFF76A25)),
                                                )),
                                                content:
                                                    const Text("GETARTIKEL!"),
                                                actions: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Center(
                                                      child: GestureDetector(
                                                          child:
                                                              const Text("OK"),
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          }),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                    },
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 56.0,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFF9E1B32),
                            ),
                            child: MaterialButton(
                                child: const Text(
                                  "TESTFILE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.0,
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyHomePageTest(
                                                  title: 'BLA'),
                                          fullscreenDialog: true));
                                }),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 56.0,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFF9E1B32),
                            ),
                            child: MaterialButton(
                                child: const Text(
                                  "Lieferant+Nr",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.0,
                                  ),
                                ),
                                onPressed: () async {
                                  if (_artNrLieferant != null &&
                                      localHersteller != null) {
                                    setState(() {
                                      localHersteller = selectedHersteller;
                                      _artNrLieferant =
                                          artNrLieferantController.text;
                                      lieferantandartikelnummer =
                                          (localHersteller! +
                                              artNrLieferantController.text);

                                      log('Lieferant: $localHersteller');
                                      log('Artikelnummer_Lieferant: $_artNrLieferant');
                                      log('lieferantandartikelnummer: $lieferantandartikelnummer');
                                    });
                                  } else {
                                    log("ArtNrLieferant ist leer");
                                  }
                                }),
                          ),*/
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
        scale: 1.2,
        child: IconButton(
          icon: ImageIcon(
            icon,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Stack(
                              children: [
                                BarcodeScannerScreen(
                                    overlayColour:
                                        Colors.black.withOpacity(0.5)),
                              ],
                            ),
                        fullscreenDialog: true))
                .then(onGoBack);
            /**.then((value) => setState(() {
            _eanBarcode = barcodeResult;
            }));*/
          },
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

  FutureOr onGoBack(dynamic value) {
    setState(() {
      if (barcodeResult != null) {
        eanCodeGlobal = barcodeResult!;
        _eanBarcode = barcodeResult;
      } else {
        eanCodeGlobal = '';
      }
    });
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
                localHersteller = selectedHersteller;
                localArtikeltyp = selectedArtikeltyp;
                localKategorie = selectedKategorie;
                _artNrLieferant = artNrLieferantController.text;
                lieferantandartikelnummer =
                    (localHersteller! + artNrLieferantController.text);
                //_artNrIntern = artNrInternController.text;
                _eanBarcode = eanCodeGlobal;
                localMaterial = selectedMaterial;
                _dimension = dimensionController.text;
                _haptik = haptikController.text;
                _optik = optikController.text;

                log('Lieferant: $localHersteller');
                log('Artikeltyp: $localArtikeltyp');
                log('Kategorie: $localKategorie');
                log('Artikelnummer_Lieferant: $_artNrLieferant');
                log('Lieferant + Artikelnummer: $lieferantandartikelnummer');
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

                selectedHersteller = null;
                selectedArtikeltyp = null;
                selectedKategorie = null;
                selectedMaterial = null;
                eanCodeGlobal = '';
                barcodeResult = null;
              });
              artNrInternString = artNrInternPlus.toString();
              log("Intern ID String Print: $artNrInternString");

              _printLabel();
              _uploadImage();

              AddartikelRequestModel model = AddartikelRequestModel(
                lieferant: localHersteller,
                artikeltyp: localArtikeltyp,
                kategorie: localKategorie,
                artnrlieferant: _artNrLieferant,
                lieferantandartikelnummer: lieferantandartikelnummer,
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
                    //_uploadImage();
                    getInternID();

                    log('Intern Bild: $artNrInternString');

                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Center(
                                  child: Text(
                                'Hurra!',
                                style: TextStyle(color: Color(0xFFF76A25)),
                              )),
                              content: const Text(
                                  'Der Artikel wurde erfolgreich angelegt'),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Container(
                                      height: 36.0,
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: const Color(0xFFF76A25),
                                      ),
                                      child: MaterialButton(
                                          child: const Text(
                                            "OK",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                    ),
                                  ),
                                ),
                              ],
                            ));
                  } else if (response.data != null && image == null) {
                    getInternID();
                    log('Intern ohne Bild: $artNrInternString');
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Center(
                                  child: Text(
                                'Hurra, aber Achtung!',
                                style: TextStyle(color: Color(0xFFF76A25)),
                              )),
                              content: const Text(
                                  'Der Artikel wurde ohne Bild hochgeladen, da keines ausgewählt/aufgenommen wurde'),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Container(
                                      height: 36.0,
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: const Color(0xFFF76A25),
                                      ),
                                      child: MaterialButton(
                                          child: const Text(
                                            "OK",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                    ),
                                  ),
                                ),
                              ],
                            ));
                  } else {
                    log("Bild hochladen fehlgeschlagen");
                    getInternID();
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Center(
                                  child: Text(
                                'Oops, ein Fehler ist aufgetreten!',
                                style: TextStyle(color: Color(0xFFF76A25)),
                              )),
                              content: Text(response.message),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Container(
                                      height: 36.0,
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: const Color(0xFFF76A25),
                                      ),
                                      child: MaterialButton(
                                          child: const Text(
                                            "OK",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                    ),
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

  Future _printLabel() async {
    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();
    final printer = NetworkPrinter(paper, profile);

    //Label Printer with static IP and Port
    //final PosPrintResult res = await printer.connect('192.168.188.115', port: 9500);

    //Office Printer
    //final PosPrintResult res = await printer.connect('192.168.188.71', port: 9100);

    //Label Printer with variable IP and Port
    final PosPrintResult res =
        await printer.connect(printerIp, port: printerPort);

    if (res == PosPrintResult.success) {
      networkPrinter(printer);
      printer.disconnect();
    }

    print('Print result: ${res.msg}');
  }

  void networkPrinter(NetworkPrinter printer) {
    //ZPL Label
    printer.text(
        '^{^XA ^JMB ^CI27 ^FO397,50^GFA,42300,42300,100,7kJFC,kKFE,::::::FF8k03FE,FFkG03FE,FFkG01FE,::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::FFkG01FEiL01FC,FFkG01FEiL03FC,FFkG01FEiL03FE,:FFkH0FCiL03FE,FFkH0FCiL07FE,FFnP07FE,::::FFnP03FE,:FFnP03FC,FFnP01,FFhY0FEjR0FC,FFhX01FFjQ03FE,FFhX03FFjQ03FE,FFhX03FFjQ07FE,:::::::::FFhX03FFhN0LFCgV07FE,FFU07OFCP088I01LFCL0601IFEO0CP0OFQ06CI07OF8R03OFCN0C01IF8N018J01BJ0308W098FFT07QFCN01FF001NF8J01VFEN01QF8N03FE001PFEQ03QFEL03VFEJ03FEI07FEV07FEFFS03SFCM01FF00PFJ01WFM01SFN03FE00RFCO01SFCK03VFEJ03FEI07FFV0FFCFFS0UFM03FF01PFCI03WFM07SFEM03FF03RFEO07TFK03WFJ07FEI07FF8T01FFCFFR01UF8L03FF07PFEI03WFL01UFM03FF07SF8M01UFCJ03WFJ07FEI03FF8T01FFCFFR03UFEL03FF0RF8001WFL03UFCL03FE0TFCM03UFEJ03WFJ07FEI01FFCT03FF8FFR07VFL03FF0RF8001WFL0VFEL03FE0TFEM07VFJ03VFEJ07FEI01FFCT03FF8FFR0WF8K03FF1RFC001WFK01WFL03FE1TFEM0WF8I03VFEJ07FEJ0FFET07FF,FFQ01JFCM0KF8K03FF3IFCJ0JFE001VFEK01KFM0KF8K03FE3JFCJ07KFM0JFEM07JFCI01VFCJ07FEJ0FFET0FFE,FFQ01IF8O03IFCK03KFM07FFEL07FFV03IFCO03IFCK03FF7FFEN0JF8K01IF8O01IFEM0IFU07FEJ07FFT0FFE,FFQ03FFEQ07FFCK03JFCM01IFL03FFV07FFEQ0IFEK03JFEO01IF8K01IFQ07FFEM07FEU07FEJ07FF8R01FFC,FFQ03FFCQ03FFEK03JFO0IFL03FFV07FF8Q03FFEK03JF8P07FFCK03FFCQ01FFEM07FEU07FEJ03FF8R01FFC,FFQ03FF8R0FFEK03IFCO07FF8K03FFV0IFR01FFEK03IFEQ03FFCK03FFCR0IFM07FEU07FEJ03FFCR03FF8,FFQ03FFS0IFK03IF8O03FF8K03FFV0FFES0IFK03IFCQ01FFCK03FF8R07FFM07FEU07FEJ01FFCR03FF8,FFQ07FFS07FFK03IFP03FF8K03FFU01FFCS07FF8J03IFS0FFEK03FF8R03FFM07FEU07FEK0FFER07FF,FFQ07FFS07FFK03FFEP01FF8K03FFU01FFCS03FF8J03FFES0FFEK03FFS03FFM07FEU07FEK0FFER0FFE,FFQ07FFS03FFK03FFCP01FF8K03FFU01FF8S03FF8J03FFES0FFEK03FFS03FF8L07FEU07FEK07FFR0FFE,FFQ07FFS03FFK03FFCQ0FFCK03FFU01FF8S01FF8J03FFCS07FEK03FFS03FF8L07FEU07FEK03FF8P01FFC,FFQ03FES03FFK03FFCQ0FFCK03FFU03FFT01FF8J03FF8S07FEK03FES01FF8L07FEU07FEK03FF8P01FFC,FFgM01FFK03FF8Q0FFCK03FFU03FFU0FFCJ03FF8S03FEgG01FF8L07FEU07FEK03FFCP03FF8,FFgM01FFK03FF8Q0FFCK03FFU03FFU0FFCJ03FF8S03FEgG01FF8L07FEU07FEK01FFCP07FF8,FFgM01FFK03FFR0FFCK03FFU03FFU0FFCJ03FFT03FEgG01FF8L07FEU07FEL0FFEP07FF,FFgM01FFK03FFR0FFCK03FFU07FEU0FFCJ03FFT03FFgG01FF8L07FEU07FEL0FFEP0FFE,FFgM01FFK03FFR0FFCK03FFU07FEU0FFCJ03FFT03FFgG01FF8L07FEU07FEL07FFP0FFE,FFgM01FFK03FFR0FFCK03FFU07FEU0FFCJ03FFT03FFgG01FF8L07FEU07FEL07FFO01FFC,FFgM01FFK03FFR0FFCK03FEU07FFU0FFCJ03FFT03FFgG01FF8L07FEU07FEL03FF8N01FFC,FFU01MFCI01FFK03FFR0FFCK03FEU07FF8S01FFEJ03FFT03FFP0MFEI01FF8L07FEU07FEL01FFCN03FF8,FFS01QFC01FFK03FFR07F8K03FEU07YFEJ03FFT03FFN0QFC01FF8L07FCU07FEL01FFCN03FF,FFR01SF81FFK03FFg03FEU07YFEJ03FFT03FFM0SF81FF8L07FCU07FEM0FFEN07FF,FFR07SFC1FFK03FFg03FEU07YFEJ03FFT03FFL03SFE1FF8L07FCU07FEM0FFEN0FFE,FFQ01TFE1FFK03FFg03FEU07YFEJ03FFT03FFL0UF0FF8L07FCU07FEM07FFN0FFE,FFQ01UF1FFK03FFg03FEU07YFEJ03FFT03FFK01UF9FF8L07FCU07FEM07FF8L01FFC,FFQ07XFK03FFg03FEU07YFCJ03FFT03FFK03XF8L07FCU07FEM03FF8L01FFC,FFQ07XFK03FFg03FEU07YFCJ03FFT03FFK07XF8L07FCU07FEM01FFCL03FF8,FFQ0NFI07MFK03FFg03FEU07YF8J03FFT03FFK07MF800NF8L07FCU07FEM01FFCL03FF,FFQ0JF8O03JFK03FFg03FEU07FFgH03FFT03FFK0JFCO01JF8L07FCU07FEN0FFEL07FF,FFP01IFCQ07IFK03FFg03FEU07FEgH03FFT03FFK0IFCQ03IF8L07FCU07FEN0FFEL0FFE,FFP01IFR01IFK03FFg03FEO03F8I07FEgH03FFT03FFK0IFS0IF8L07FCO07FJ07FEN07FFL0FFE,FFP01FFES0IFK03FFg03FEO07F8I07FEgH03FFT03FFJ01FFES0IF8L07FCO0FFJ07FEN03FF8J01FFC,FFP03FFCS07FFK03FFg07FEO07F8I07FEgH03FFT03FFJ01FFCS03FF8L07FCO0FFJ07FEN03FF8J01FF8,FFP03FF8S03FFK03FFg07FEO0FF8I07FEgH03FFT03FFJ01FF8S03FF8L07FCO0FF8I07FEN03FFCJ03FF8,FFP03FF8S03FFK03FFg07FEO07F8I07FEgH03FFT03FFJ01FF8S03FF8L07FCO0FF8I07FEN01FFCJ03FF8,FFP03FFT01FFK03FFg07FEO07F8I07FFgH03FFT03FFJ03FF8S01FF8L07FCO0FFJ07FEO0FFEJ07FF,FFP03FFT01FFK03FFg07FEO07F8I07FFgH03FFT03FFJ03FF8S01FF8L07FCO0FFJ07FEO0FFEJ0FFE,FFP03FFT01FFK03FFg07FEO07F8I03FFgH03FFT03FFJ03FF8S01FF8L07FCO0FFJ07FEO07FFJ0FFE,FFP03FFT01FFK03FFg07FEO07F8I03FFgH03FFT03FFJ03FF8S01FF8L07FCO0FFJ07FEO03FF8001FFC,FFP03FFT01FFK03FFg07FEO07F8I03FFU07F8J03FFT03FFJ03FF8S01FF8L07FCO0FFJ07FEO03FF8001FF8,FFP03FFT01FFK03FFg03FEO0FF8I03FF8T0FFCJ03FFT03FFJ03FF8S01FF8L07FEN01FFJ07FEO01FFC003FF8,FFP03FFT01FFK03FFg03FFO0FF8I01FF8T0FFCJ03FFT03FFJ03FF8S01FF8L07FEN01FFJ07FEO01FFC007FF,FFP03FFT03FFK03FFg03FFO0FF8I01FF8T0FFCJ03FFT03FFJ01FF8S01FF8L07FEN01FFJ07FEP0FFE007FF,FFP03FF8S03FFK03FFg03FFO0FF8I01FFCS01FFCJ03FFT03FFJ01FF8S03FF8L07FEN01FFJ07FEP0IF007FE,FFP03FF8S07FFK03FFg03FF8N0FF8I01FFES03FF8J03FFT03FFJ01FF8S03FF8L07FFN01FFJ07FEP07FF00FFE,FFP03FFCS07FFK03FFg03FF8M01FF8J0FFES03FF8J03FFT03FFJ01FFCS07FF8L07FFN03FFJ07FEP07FF01FFC,FFP01FFCS0IFK03FFg03FFCM03FF8J0IF8R07FF8J03FFT03FFJ01FFES0IF8L07FF8M03FFJ07FEP03FF81FFC,FFP01FFER03IFK03FFg03FFEM03FF8J07FFCQ01IFK03FFT03FFK0IFR01IF8L03FFCM07FFJ07FEP01FFC3FF8,FFQ0IF8Q0JFK03FFg01IFM0IFK07IFQ07FFEK03FFT03FFK0IF8Q07IF8L03FFEL01FFEJ07FEP01FFC3FF,FFQ0IFCP03JFK03FFg01IFCK01IFK03IFCO03IFEK03FFT03FFK0IFEP01JF8L01IF8K03FFEJ07FEQ0FFEIF,FFQ07JF8L07LFK03FFgG0KFI03IFEK01KFCK01KFCK03FFT03FFK07JFCL01LF8L01JFEI07IFCJ07FEQ07JFE,FFQ07XFK03FFgG07QFEL0WF8K03FFT03FFK03XF8M0RFCJ07FEQ07JFE,FFQ03UFBFFK03FFgG03QFCL07VFL03FFT03FFK03XF8M07QF8J07FEQ07JFC,FFQ01UF1FFK03FFgG01QF8L03UFEL03FFT03FFK01UF0FF8M03QFK07FEQ03JFC,FFR0TFE1FFK03FFgH0QFM01UFCL03FFT03FFL07TF0FF8M01PFEK07FEQ01JF8,FFR07SFC1FFK03FFgH07OFCN03SFEM03FFT03FEL03SFE1FF8N07OFCK07FEQ01JF,FFR01SF81FFK01FFgH01OF8O0SF8M03FET03FEM0SF80FF8N03OFL03FER0JF,FFS01QFC00FEK01FEgI01MFCQ0QFO01FCT01FEM01QFC007FP07MF8L01FCR07FFE,FFT01OFCgW01KFCS03MFCgY0OFCV07KF8,FFW03JFhH03FFX0IF8hI07JF8g07FE,FF,::::::::::::::::FF8,kKFE,kLF8,kLFC,::::kLF8,^FS ^FX ^CFA,20 ^FO350,340^FH^AFN,28,18^FDArtikeltyp: $localArtikeltyp^FS ^FO349,340^FH^AFN,28,18^FDArtikeltyp:^FS ^FO351,340^FH^AFN,28,18^FDArtikeltyp:^FS ^FO352,340^FH^AFN,28,18^FDArtikeltyp:^FS  ^FO350,380^AFN,28,18^FDKategorie: $localKategorie^FS ^FO349,380^AFN,28,18^FDKategorie:^FS ^FO351,380^AFN,28,18^FDKategorie:^FS ^FO352,380^AFN,28,18^FDKategorie:^FS ^FO350,420^AFN,28,18^FDArtikelnummer: $artNrInternString^FS ^FO349,420^AFN,28,18^FDArtikelnummer:^FS ^FO351,420^AFN,28,18^FDArtikelnummer:^FS ^FO352,420^AFN,28,18^FDArtikelnummer:^FS ^FO100,160^BQN,2,10^FDQA $artNrInternString^FS ^XZ}');
    printer.feed(6);
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

  void getInternID() {
    setState(() {
      APIService.getlastinternid();
    });
  }
}

void clearHersteller() {
  kategorien = [];
  materialien = [];
}

void clearArtikeltyp() {
  materialien = [];
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
