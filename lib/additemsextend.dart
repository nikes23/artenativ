import 'dart:developer';
import 'dart:async';
import 'dart:io';
import 'package:artenativ/components/barcodescanner.dart';
import 'package:artenativ/models/artikel_request.dart';
import 'package:artenativ/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'models/ItemDataModel.dart';
import 'dart:math' as math;
import 'package:artenativ/home.dart';
import 'package:artenativ/login.dart';
import 'package:flutter/material.dart';
import 'package:artenativ/globals.dart';

class AddItemsExtendScreen extends StatefulWidget {
  final Artikel items;

  const AddItemsExtendScreen({Key? key, required this.items}) : super(key: key);

  @override
  _AddItemsExtendScreenState createState() =>
      _AddItemsExtendScreenState(items: this.items);
}

class _AddItemsExtendScreenState extends State<AddItemsExtendScreen> {
  final Artikel items;
  _AddItemsExtendScreenState({required this.items});
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<FormFieldState>();

  double roundDouble(double value, int places) {
    num mod = math.pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  var file, extention, imagePath;

  String response = '';

  String localHersteller = '';
  String localArtikeltyp = '';
  String localKategorie = '';
  String localBeanspruchung = '';
  String localVerfugbarkeit = '';
  String localMaterial = '';
  String lieferantandartikelnummer = '';
  String localEinzelnVerpackungseinheiten = '';
  String? localBundVerpackungseinheiten = '';

  //Variables for Textfields Content
  String _artNrLieferant = '';
  String _artNrIntern = '';
  String _eanBarcode = '';
  String _bezeichnung = '';
  String _dimension = '';
  String _haptik = '';
  String _optik = '';
  String _sortierung = '';
  String _vpeEinzeln = '';
  String _vpeBund = '';
  String _eigenschaft = '';
  String _einkaufspreis = '';
  String _verkaufspreisEins = '';
  String _verkaufspreisZwei = '';
  String _verkaufspreisDrei = '';
  String _verkaufspreisMwSt = '0';
  String _ausstellungsplatz = '';

  TextEditingController artNrLieferantController = TextEditingController();
  TextEditingController artNrInternController = TextEditingController();
  TextEditingController eanBarcodeController = TextEditingController();
  TextEditingController bezeichnungController = TextEditingController();
  TextEditingController dimensionController = TextEditingController();
  TextEditingController haptikController = TextEditingController();
  TextEditingController optikController = TextEditingController();
  TextEditingController sortierungController = TextEditingController();
  TextEditingController vpeEinzelnController = TextEditingController();
  TextEditingController vpeBundController = TextEditingController();
  TextEditingController eigenschaftController = TextEditingController();
  final einkaufspreisController = TextEditingController();
  TextEditingController verkaufspreisEinsController = TextEditingController();
  TextEditingController verkaufspreisZweiController = TextEditingController();
  TextEditingController verkaufspreisDreiController = TextEditingController();
  TextEditingController verkaufspreisMwStController =
      TextEditingController(text: "0");
  TextEditingController ausstellungsplatzController = TextEditingController();

  File? image;
  String? imageName;
  var imageContainer;

  @override
  void initState() {
    artTypen = [items.artikeltyp];
    kategorien = [items.kategorie];
    materialien = [items.material];
    selectedHersteller = items.lieferant;
    selectedArtikeltyp = items.artikeltyp;
    selectedKategorie = items.kategorie;
    selectedMaterial = items.material;
    selectedBeanspruchung = items.beanspruchungsklasse;
    selectedVerfugbarkeit = items.verfugbarkeit;
    _artNrLieferant = items.artnrlieferant;
    _artNrIntern = items.artnrintern;
    _eanBarcode = items.eancode;
    if (barcodeResult != null) {
      _eanBarcode = barcodeResult!;
    }
    if (items.bezeichnung == null) {
      _bezeichnung = bezeichnungController.text;
    } else if (items.bezeichnung != null) {
      _bezeichnung = items.bezeichnung!;
    }
    _dimension = items.dimension;
    _haptik = items.haptik;
    _optik = items.optik;
    if (items.sortierung == null) {
      _sortierung = sortierungController.text;
    } else if (items.sortierung != null) {
      _sortierung = items.sortierung!;
    }
    if (items.vpeeinzeln == null) {
      _vpeEinzeln = vpeEinzelnController.text;
    } else if (items.vpeeinzeln != null) {
      _vpeEinzeln = items.vpeeinzeln!;
    }
    if (items.vpebund == null) {
      _vpeBund = vpeBundController.text;
    } else if (items.vpebund != null) {
      _vpeBund = items.vpebund!;
    }
    if (items.einzelneinheit == '') {
      selectedEinzelnVerpackungseinheiten = null;
    } else if (items.einzelneinheit != null) {
      selectedEinzelnVerpackungseinheiten = items.einzelneinheit;
    }
    if (items.bundeinheit == '') {
      //localBundVerpackungseinheiten = null;
      selectedBundVerpackungseinheiten = null;
    } else if (items.bundeinheit != null) {
      //localBundVerpackungseinheiten = items.bundeinheit.toString();
      selectedBundVerpackungseinheiten = items.bundeinheit;
    }
    if (items.eigenschaft == null) {
      _eigenschaft = eigenschaftController.text;
    } else if (items.eigenschaft != null) {
      _eigenschaft = items.eigenschaft!;
    }
    if (items.einkaufspreis == null) {
      _einkaufspreis = einkaufspreisController.text;
    } else if (items.einkaufspreis != null) {
      _einkaufspreis = items.einkaufspreis!;
    }
    if (items.verkaufspreiseins == null) {
      _verkaufspreisEins = verkaufspreisEinsController.text;
    } else if (items.verkaufspreiseins != null) {
      _verkaufspreisEins = items.verkaufspreiseins!;
    }
    if (items.verkaufspreiszwei == null) {
      _verkaufspreisZwei = verkaufspreisZweiController.text;
    } else if (items.verkaufspreiszwei != null) {
      _verkaufspreisZwei = items.verkaufspreiszwei!;
    }
    if (items.verkaufspreisdrei == null) {
      _verkaufspreisDrei = verkaufspreisDreiController.text;
    } else if (items.verkaufspreisdrei != null) {
      _verkaufspreisDrei = items.verkaufspreisdrei!;
    }
    _verkaufspreisMwSt = verkaufspreisMwStController.text;
    if (items.ausstellplatz == null) {
      _ausstellungsplatz = ausstellungsplatzController.text;
    } else if (items.ausstellplatz != null) {
      _ausstellungsplatz = items.ausstellplatz!;
    }
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    selectedHersteller = null;
    selectedArtikeltyp = null;
    selectedKategorie = null;
    selectedMaterial = null;
    selectedBeanspruchung = null;
    selectedVerfugbarkeit = null;
    selectedEinzelnVerpackungseinheiten = null;
    selectedBundVerpackungseinheiten = null;
    barcodeResult = null;
    artTypen = [];
    kategorien = [];
    materialien = [];
    artNrLieferantController.dispose();
    artNrInternController.dispose();
    eanBarcodeController.dispose();
    bezeichnungController.dispose();
    dimensionController.dispose();
    haptikController.dispose();
    optikController.dispose();
    sortierungController.dispose();
    vpeEinzelnController.dispose();
    vpeBundController.dispose();
    eigenschaftController.dispose();
    einkaufspreisController.dispose();
    verkaufspreisEinsController.dispose();
    verkaufspreisZweiController.dispose();
    verkaufspreisDreiController.dispose();
    verkaufspreisMwStController.dispose();
    ausstellungsplatzController.dispose();
    _formKey.currentState?.reset();
    _key.currentState?.reset();
    log('Dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        /*leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.pop(context);
            }),*/
        centerTitle: true,
        elevation: 0,
        title: const Text('Bearbeiten'),
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
                        top: 30.0, right: 20.0, left: 20.0, bottom: 20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /*
                          const SizedBox(
                            width: 600,
                            child: Center(
                              child: Text(
                                'Artikel bearbeiten',
                                style: TextStyle(
                                  color: Color(0xFFF76A25),
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          */
                          const SizedBox(
                            height: 20.0,
                          ),
                          getListView(context),
                          //Lieferant
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
                                  //value: items.lieferant,
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

                                      localHersteller = selectedHersteller!;
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
                                  key: _key,
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
                                  //value: items.artikeltyp,
                                  value: selectedArtikeltyp,
                                  onSaved: (value) => selectedArtikeltyp,
                                  onChanged: (artikeltyp) {
                                    if (artikeltyp == 'Fliesen') {
                                      kategorien = fliesenKategorie;
                                    } else if (artikeltyp == 'Parkett') {
                                      kategorien = parkettKategorie;
                                    } else if (artikeltyp == 'Garten') {
                                      kategorien = gartenKategorie;
                                    } else if (artikeltyp == 'Profile') {
                                      kategorien = profileKategorie;
                                    } else if (artikeltyp == 'Beläge') {
                                      kategorien = belaegeKategorie;
                                    } else if (artikeltyp == 'Chemie') {
                                      kategorien = chemieKategorie;
                                    } else if (artikeltyp == 'Naturbaustoffe') {
                                      kategorien = naturbaustoffeKategorie;
                                    } else if (artikeltyp == 'Holz') {
                                      kategorien = holzKategorie;
                                    } else if (artikeltyp == 'Bau') {
                                      kategorien = bauKategorie;
                                    } else if (artikeltyp == 'Unterlagen') {
                                      kategorien = unterlagenKategorie;
                                    } else if (artikeltyp == 'Sockelleisten') {
                                      kategorien = sockelleistenKategorie;
                                    } else if (artikeltyp == 'Stein') {
                                      kategorien = keineKategorie;
                                    } else if (artikeltyp ==
                                        'Werkzeuge und Zubehör') {
                                      kategorien = werkzeugeZubehoerKategorie;
                                    } else if (artikeltyp == 'Schreinerei') {
                                      kategorien = keineKategorie;
                                    } else if (artikeltyp == 'Glaserei') {
                                      kategorien = keineKategorie;
                                    } else if (artikeltyp == 'Metallbau') {
                                      kategorien = keineKategorie;
                                    } else if (artikeltyp == null) {
                                      setState(() {
                                        List<String> glob;
                                        kategorien = [];
                                        glob = kategorien;
                                        log('LogELSE: $glob');
                                      });
                                    } else {
                                      setState(() {
                                        List<String> glob;
                                        kategorien = [];
                                        glob = kategorien;
                                        log('LogELSE: $glob');
                                      });
                                    }
                                    setState(() {
                                      selectedKategorie = null;
                                      selectedArtikeltyp =
                                          artikeltyp! as String?;

                                      localArtikeltyp = selectedArtikeltyp!;
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
                                  //value: items.kategorie,
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

                                      localKategorie = selectedKategorie!;
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
                                  controller: artNrLieferantController
                                    ..text = _artNrLieferant,
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
                                  onChanged: (value) {
                                    _artNrLieferant =
                                        artNrLieferantController.text;
                                  },
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
                                  controller: artNrInternController
                                    ..text = _artNrIntern,
                                  enabled: false,
                                  //validator: UserNameValidator.validate,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    LengthLimitingTextInputFormatter(20),
                                  ],
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration: buildInputDecorationIconDisable(
                                      'Artikelnummer eingeben', Icons.numbers),
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
                                    ..text = _eanBarcode,
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
                                  onChanged: (value) {
                                    _eanBarcode = eanBarcodeController.text;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          //Bezeichnung
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Bezeichnung*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: bezeichnungController
                                    ..text = _bezeichnung,
                                  //validator: UserNameValidator.validate,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration: buildInputDecoration(
                                      'Bezeichnung eingeben'),
                                  onSaved: (value) => _bezeichnung = value!,
                                  onChanged: (value) {
                                    _bezeichnung = bezeichnungController.text;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Bitte geben Sie eine Bezeichnung ein';
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
                                  //value: items.material,
                                  value: selectedMaterial,
                                  onSaved: (value) => selectedMaterial,
                                  onChanged: (material) {
                                    setState(() {
                                      selectedMaterial = material as String?;
                                      localMaterial = selectedMaterial!;
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
                                  controller: dimensionController
                                    ..text = _dimension,
                                  //validator: UserNameValidator.validate,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration: buildInputDecoration(
                                      'Dimension eingeben'),
                                  onSaved: (value) => _dimension = value!,
                                  onChanged: (value) {
                                    _dimension = dimensionController.text;
                                  },
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
                                  controller: haptikController..text = _haptik,
                                  //validator: UserNameValidator.validate,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration:
                                      buildInputDecoration('Haptik eingeben'),
                                  onSaved: (value) => _haptik = value!,
                                  onChanged: (value) {
                                    _haptik = haptikController.text;
                                  },
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
                                  controller: optikController..text = _optik,
                                  //validator: UserNameValidator.validate,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration:
                                      buildInputDecoration('Optik eingeben'),
                                  onSaved: (value) => _optik = value!,
                                  onChanged: (value) {
                                    _optik = optikController.text;
                                  },
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
                          //Sortierung
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Sortierung*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: sortierungController
                                    ..text = _sortierung,
                                  //validator: UserNameValidator.validate,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration: buildInputDecoration(
                                      'Sortierung eingeben'),
                                  onSaved: (value) => _sortierung = value!,
                                  onChanged: (value) {
                                    _sortierung = sortierungController.text;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Bitte geben Sie die Sortierung ein';
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
                          //VPE Einzeln
                          SizedBox(
                            width: 600,
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'VPE Einzeln*',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: vpeEinzelnController
                                          ..text = _vpeEinzeln,
                                        //validator: UserNameValidator.validate,
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                        decoration: buildInputDecoration(
                                            'Einzeln eingeben'),
                                        onSaved: (value) =>
                                            _vpeEinzeln = value!,
                                        onChanged: (value) {
                                          _vpeEinzeln =
                                              vpeEinzelnController.text;
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'VPE Einzeln eingeben';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      children: [
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DropdownButtonFormField(
                                          menuMaxHeight: 700.0,
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          isExpanded: true,
                                          decoration:
                                              buildInputDecorationDropdown(),
                                          validator: (value) => value == null
                                              ? "Einheit auswählen"
                                              : null,
                                          dropdownColor: Colors.white,
                                          //value: items.einzelneinheit,
                                          value:
                                              selectedEinzelnVerpackungseinheiten,
                                          onSaved: (value) =>
                                              selectedEinzelnVerpackungseinheiten,
                                          onChanged: (einheit) {
                                            setState(() {
                                              selectedEinzelnVerpackungseinheiten =
                                                  einheit as String?;
                                              localEinzelnVerpackungseinheiten =
                                                  selectedEinzelnVerpackungseinheiten!;
                                            });
                                          },
                                          items: verpackungseinheiten,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          //VPE Bund
                          SizedBox(
                            width: 600,
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'VPE Bund',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: vpeBundController
                                          ..text = _vpeBund,
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                        decoration: buildInputDecoration(
                                            'Bund eingeben'),
                                        onSaved: (value) => _vpeBund = value!,
                                        onChanged: (value) {
                                          _vpeBund = vpeBundController.text;
                                        },
                                        validator: (value) {
                                          if (value == "") {
                                            return null;
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      children: [
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DropdownButtonFormField(
                                          menuMaxHeight: 700.0,
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          isExpanded: true,
                                          decoration:
                                              buildInputDecorationDropdown(),
                                          validator: (value) =>
                                              value == null ? null : null,
                                          dropdownColor: Colors.white,
                                          //value: items.bundeinheit,
                                          value:
                                              selectedBundVerpackungseinheiten,
                                          onSaved: (value) =>
                                              selectedBundVerpackungseinheiten,
                                          onChanged: (einheit) {
                                            setState(() {
                                              selectedBundVerpackungseinheiten =
                                                  einheit as String?;
                                              localBundVerpackungseinheiten =
                                                  selectedBundVerpackungseinheiten!;
                                            });
                                          },
                                          items: verpackungseinheitenBund,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          //Eigenschaft
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Eigenschaft*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: eigenschaftController
                                    ..text = _eigenschaft,
                                  //validator: UserNameValidator.validate,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration: buildInputDecoration(
                                      'Eigenschaft eingeben'),
                                  onSaved: (value) => _eigenschaft = value!,
                                  onChanged: (value) {
                                    _eigenschaft = eigenschaftController.text;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Bitte geben Sie die Eigenschaft ein';
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
                          //Beanspruchungsklasse
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Beanspruchungsklasse*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                DropdownButtonFormField(
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  decoration: buildInputDecorationDropdown(),
                                  validator: (value) => value == null
                                      ? "Wählen Sie bitte eine Beanspruchungsklasse aus!"
                                      : null,
                                  dropdownColor: Colors.white,
                                  //value: items.beanspruchungsklasse,
                                  value: selectedBeanspruchung,
                                  onSaved: (value) => selectedBeanspruchung,
                                  onChanged: (beanspruchung) {
                                    setState(() {
                                      selectedBeanspruchung =
                                          beanspruchung as String?;
                                      localBeanspruchung =
                                          selectedBeanspruchung!;
                                    });
                                  },
                                  items: beanspruchungsKlassen,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          //Verfügbarkeit
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Verfügbarkeit*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                DropdownButtonFormField(
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  decoration: buildInputDecorationDropdown(),
                                  validator: (value) => value == null
                                      ? "Wählen Sie bitte eine Verfügbarkeit aus!"
                                      : null,
                                  dropdownColor: Colors.white,
                                  //value: items.verfugbarkeit,
                                  value: selectedVerfugbarkeit,
                                  onSaved: (value) => selectedVerfugbarkeit,
                                  onChanged: (verfugbarkeit) {
                                    setState(() {
                                      selectedVerfugbarkeit =
                                          verfugbarkeit as String?;
                                      localVerfugbarkeit =
                                          selectedVerfugbarkeit!;
                                    });
                                  },
                                  items: verfugbarkeit,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          //Einkaufspreis
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Einkaufspreis*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: einkaufspreisController
                                    ..text = _einkaufspreis,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+[,.]?\d{0,2}')),
                                    TextInputFormatter.withFunction(
                                      (oldValue, newValue) => newValue.copyWith(
                                        text:
                                            newValue.text.replaceAll('.', ','),
                                      ),
                                    ),
                                  ],
                                  /*
                                  //Number TextField with , and more than 2 decimal digits
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                                    TextInputFormatter.withFunction(
                                      (oldValue, newValue) => newValue.copyWith(
                                        text:
                                            newValue.text.replaceAll('.', ','),
                                      ),
                                    ),
                                  ],
                                   */
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration: buildInputDecoration(
                                      'Einkaufspreis eingeben'),
                                  onSaved: (value) => _einkaufspreis = value!,
                                  onChanged: (value) {
                                    _einkaufspreis =
                                        einkaufspreisController.text;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Bitte geben Sie den Einkaufspreis ein';
                                    } else {
                                      setState(() {
                                        int testnumbe = 20;
                                        int sum = int.parse(
                                                einkaufspreisController.text) +
                                            testnumbe;
                                        einkauf = sum.toString();
                                      });
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
                          //Verkaufspreis 1
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Verkaufspreis 1',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: verkaufspreisEinsController
                                    ..text = _verkaufspreisEins,
                                  //validator: UserNameValidator.validate,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+[,.]?\d{0,2}')),
                                    TextInputFormatter.withFunction(
                                      (oldValue, newValue) => newValue.copyWith(
                                        text:
                                            newValue.text.replaceAll('.', ','),
                                      ),
                                    ),
                                  ],
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration: buildInputDecoration(
                                      'Verkaufspreis 1 eingeben'),
                                  onSaved: (value) =>
                                      _verkaufspreisEins = value!,
                                  onChanged: (value) {
                                    _verkaufspreisEins =
                                        verkaufspreisEinsController.text;
                                  },
                                  validator: (value) {
                                    if (value == "") {
                                      return null;
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
                          //Verkaufspreis 2
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Verkaufspreis 2',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: verkaufspreisZweiController
                                    ..text = _verkaufspreisZwei,
                                  //validator: UserNameValidator.validate,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+[,.]?\d{0,2}')),
                                    TextInputFormatter.withFunction(
                                      (oldValue, newValue) => newValue.copyWith(
                                        text:
                                            newValue.text.replaceAll('.', ','),
                                      ),
                                    ),
                                  ],
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration: buildInputDecoration(
                                      'Verkaufspreis 2 eingeben'),
                                  onSaved: (value) =>
                                      _verkaufspreisZwei = value!,
                                  onChanged: (value) {
                                    _verkaufspreisZwei =
                                        verkaufspreisZweiController.text;
                                  },
                                  validator: (value) {
                                    if (value == "") {
                                      return null;
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
                          //Verkaufspreis 3
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Verkaufspreis 3*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: verkaufspreisDreiController
                                    ..text = _verkaufspreisDrei,
                                  //validator: UserNameValidator.validate,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+[,.]?\d{0,2}')),
                                    TextInputFormatter.withFunction(
                                      (oldValue, newValue) => newValue.copyWith(
                                        text:
                                            newValue.text.replaceAll('.', ','),
                                      ),
                                    ),
                                  ],
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration: buildInputDecoration(
                                      'Verkaufspreis 3 eingeben'),
                                  onSaved: (value) =>
                                      _verkaufspreisDrei = value!,
                                  onChanged: (vkdrei) {
                                    if (vkdrei == '' || vkdrei.isEmpty) {
                                      _verkaufspreisDrei =
                                          verkaufspreisDreiController.text;
                                      /*setState(() {
                                        mwstCalculate = 0;
                                        verkaufspreisMwStController.clear();
                                        verkaufspreisMwStController.text = "0";
                                      });*/
                                    } else {
                                      _verkaufspreisDrei =
                                          verkaufspreisDreiController.text;
                                      /*setState(() {
                                        String? mwstPlaceholder1 =
                                            (verkaufspreisDreiController.text
                                                .replaceAll(",", "."));
                                        double mwstPlaceholder11 =
                                            double.parse(mwstPlaceholder1);
                                        mwstPlaceholder11.toStringAsFixed(2);
                                        log('DoubleCont: ${mwstPlaceholder11}');
                                        mwstCalculate = double.parse(
                                            (mwstPlaceholder11 * 119 / 100)
                                                .toStringAsFixed(2));
                                        mwstCalculate.toStringAsFixed(2);
                                        log('mwResult: ${mwstCalculate}');
                                        mwstResult = mwstCalculate.toString();
                                        verkaufspreisMwStController.text =
                                            mwstResult
                                                .toString()
                                                .replaceAll(".", ",");
                                      });*/
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      setState(() {
                                        mwstCalculate = 0;
                                        verkaufspreisMwStController.clear();
                                      });
                                      return 'Bitte geben Sie den Verkaufspreis 3 ein';
                                    } else {
                                      setState(() {
                                        String? mwstPlaceholder1 =
                                            (verkaufspreisDreiController.text
                                                .replaceAll(",", "."));
                                        double mwstPlaceholder11 =
                                            double.parse(mwstPlaceholder1);
                                        mwstPlaceholder11.toStringAsFixed(2);
                                        log('DoubleCont: ${mwstPlaceholder11}');
                                        mwstCalculate = double.parse(
                                            (mwstPlaceholder11 * 119 / 100)
                                                .toStringAsFixed(2));
                                        mwstCalculate.toStringAsFixed(2);
                                        log('mwResult: ${mwstCalculate}');
                                        mwstResult = mwstCalculate.toString();
                                        verkaufspreisMwStController.text =
                                            mwstResult
                                                .toString()
                                                .replaceAll(".", ",");
                                      });
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
                          //Verkaufspreis inkl. MwSt 19%
                          /**
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Verkauspreis inkl. MwSt.*',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: verkaufspreisMwStController,
                                  enabled: false,
                                  //initialValue: _verkaufspreisMwSt,
                                  //validator: UserNameValidator.validate,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+[,.]?\d{0,2}')),
                                    TextInputFormatter.withFunction(
                                      (oldValue, newValue) => newValue.copyWith(
                                        text:
                                            newValue.text.replaceAll('.', ','),
                                      ),
                                    ),
                                  ],
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration: buildInputDecorationDisable('0'),
                                  onSaved: (value) =>
                                      _verkaufspreisMwSt = value!,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '0') {
                                      return 'Bitte geben Sie für die Berechnung einen Verkaufspreis 3 ein';
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
                          //Ausstellplatz
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                const Align(
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
                                TextFormField(
                                  controller: ausstellungsplatzController
                                    ..text = _ausstellungsplatz,
                                  //validator: UserNameValidator.validate,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  decoration: buildInputDecoration(
                                      'Ausstellplatz eingeben'),
                                  onSaved: (value) =>
                                      _ausstellungsplatz = value!,
                                  onChanged: (value) {
                                    _ausstellungsplatz =
                                        ausstellungsplatzController.text;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Bitte geben Sie den Ausstellplatz ein';
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

  void clearHersteller() {
    kategorien = [];
    materialien = [];
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
      contentPadding: const EdgeInsets.fromLTRB(15.0, 18.0, 15.0, 18.0),
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

  InputDecoration buildInputDecorationIconDisable(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
      filled: true,
      fillColor: const Color(0xFFD3D3D3),
      focusColor: Colors.black,
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(width: 2, color: Color(0xFFD3D3D3)),
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

  InputDecoration buildInputDecorationDisable(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
      filled: true,
      fillColor: const Color(0xFFD3D3D3),
      focusColor: Colors.black,
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(width: 2, color: Color(0xFFD3D3D3)),
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
      _eanBarcode = barcodeResult!;
    });
  }

  InputDecoration buildInputDecorationImageDisable(
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
      fillColor: const Color(0xFFD3D3D3),
      focusColor: Colors.black,
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(width: 2, color: Color(0xFFD3D3D3)),
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
            'Aktualisieren',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23.0,
            ),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              setState(() {
                localHersteller = selectedHersteller!;
                localArtikeltyp = selectedArtikeltyp!;
                localKategorie = selectedKategorie!;
                _artNrLieferant = artNrLieferantController.text;
                lieferantandartikelnummer =
                    (localHersteller + artNrLieferantController.text);
                _eanBarcode = eanBarcodeController.text;
                _bezeichnung = bezeichnungController.text;
                localMaterial = selectedMaterial!;
                _dimension = dimensionController.text;
                _haptik = haptikController.text;
                _optik = optikController.text;
                _sortierung = sortierungController.text;
                _vpeEinzeln = vpeEinzelnController.text;
                localEinzelnVerpackungseinheiten =
                    selectedEinzelnVerpackungseinheiten!;
                _vpeBund = vpeBundController.text;
                if (selectedBundVerpackungseinheiten == null) {
                  localBundVerpackungseinheiten = null;
                } else if (selectedBundVerpackungseinheiten != null) {
                  localBundVerpackungseinheiten =
                      selectedBundVerpackungseinheiten!;
                }
                _eigenschaft = eigenschaftController.text;
                localBeanspruchung = selectedBeanspruchung!;
                localVerfugbarkeit = selectedVerfugbarkeit!;
                _einkaufspreis = einkaufspreisController.text;
                _verkaufspreisEins = verkaufspreisEinsController.text;
                _verkaufspreisZwei = verkaufspreisZweiController.text;
                _verkaufspreisDrei = verkaufspreisDreiController.text;
                //_verkaufspreisMwSt = verkaufspreisMwStController.text;
                _ausstellungsplatz = ausstellungsplatzController.text;

                log('Lieferant: $localHersteller');
                log('Artikeltyp: $localArtikeltyp');
                log('Kategorie: $localKategorie');
                log('Artikelnummer_Lieferant: $_artNrLieferant');
                log('Lieferant + Artikelnummer: $lieferantandartikelnummer');
                log('Artikelnummer_Intern: $_artNrIntern');
                log('EAN Barcodenummer: $_eanBarcode');
                log('Bezeichnung: $_bezeichnung');
                log('Material: $localMaterial');
                log('Dimension: $_dimension');
                log('Haptik: $_haptik');
                log('Optik: $_optik');
                log('Sortierung: $_sortierung');
                log('VPE Einzeln: $_vpeEinzeln');
                log('VPE Einzeln Einheit: $localEinzelnVerpackungseinheiten');
                log('VPE Bund: $_vpeBund');
                log('VPE Bund Einheit: $localBundVerpackungseinheiten');
                log('Eigenschaft: $_eigenschaft');
                log('Beanspruchung: $localBeanspruchung');
                log('Verfügbarkeit: $localVerfugbarkeit');
                log('Einkaufspreis: $_einkaufspreis');
                log('Verkaufspreis 1: $_verkaufspreisEins');
                /**
                    double test1 = 20.40;
                    double test2 = 21.30;
                    var testresutl = test1 + test2;
                    log('Testrechnung: $testresutl');
                    log('MwStRechnung: $mwstCalculate');
                 */
                log('Verkaufspreis 2: $_verkaufspreisZwei');
                log('Verkaufspreis 3: $_verkaufspreisDrei');
                log('Verkaufspreis MwSt: $_verkaufspreisMwSt');
                log('Ausstellplatz: $_ausstellungsplatz');

                artNrLieferantController.clear();
                //artNrInternController.clear();
                eanBarcodeController.clear();
                bezeichnungController.clear();
                dimensionController.clear();
                haptikController.clear();
                optikController.clear();
                sortierungController.clear();
                vpeEinzelnController.clear();
                vpeBundController.clear();
                eigenschaftController.clear();
                einkaufspreisController.clear();
                verkaufspreisEinsController.clear();
                verkaufspreisZweiController.clear();
                verkaufspreisDreiController.clear();
                //verkaufspreisMwStController.clear();
                ausstellungsplatzController.clear();

                selectedHersteller = null;
                selectedArtikeltyp = null;
                selectedKategorie = null;
                selectedMaterial = null;
                selectedBeanspruchung = null;
                selectedVerfugbarkeit = null;
                selectedEinzelnVerpackungseinheiten = null;
                selectedBundVerpackungseinheiten = null;
                eanCodeGlobal = '';
                barcodeResult = null;
              });

              //_uploadImage();

              Artikel model = Artikel(
                lieferant: localHersteller,
                artikeltyp: localArtikeltyp,
                kategorie: localKategorie,
                artnrlieferant: _artNrLieferant,
                lieferantandartikelnummer: lieferantandartikelnummer,
                artnrintern: items.artnrintern,
                eancode: _eanBarcode,
                bezeichnung: _bezeichnung,
                material: localMaterial,
                dimension: _dimension,
                haptik: _haptik,
                optik: _optik,
                sortierung: _sortierung,
                vpeeinzeln: _vpeEinzeln,
                einzelneinheit: localEinzelnVerpackungseinheiten,
                vpebund: _vpeBund,
                bundeinheit: localBundVerpackungseinheiten,
                eigenschaft: _eigenschaft,
                beanspruchungsklasse: localBeanspruchung,
                verfugbarkeit: localVerfugbarkeit,
                einkaufspreis: _einkaufspreis,
                verkaufspreiseins: _verkaufspreisEins,
                verkaufspreiszwei: _verkaufspreisZwei,
                verkaufspreisdrei: _verkaufspreisDrei,
                ausstellplatz: _ausstellungsplatz,
                imageName: imageName,
                //imageName: imageName,
              );

              APIService.updateartikel(model, model.artnrintern).then(
                (response) {
                  setState(() {
                    //isApiCallProcess = false;
                  });

                  if (response.data != null && image != null) {
                    _uploadImage();
                    log("Bild wurde hochgeladen");
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
                                  'Der Artikel wurde erfolgreich aktualisiert!'),
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
                    Navigator.pop(context);
                    //Navigator.pop(context);
                  } else if (response.data != null && image == null) {
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
                                  'Der Artikel wurde ohne Bild aktualisiert, weil kein neues ausgewählt oder aufgenommen wurde!'),
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
                    Navigator.pop(context);
                    //Navigator.pop(context);
                  } else {
                    log("Bild hochladen fehlgeschlagen");
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
                    Navigator.pop(context);
                    //Navigator.pop(context);
                  }
                },
              );
            }
          }),
    );
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
          /**child: items.imagePath != null
              ? Hero(
                  tag: items.artnrintern,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(items.imagePath.toString()
                        //'https://wiplano.de/media/image/product/91860/md/landhausdiele-3-schicht-eiche-rustique-5g-zufaellige-oberflaechenveredelung-schwarz-gespachtelt-1100-x-190-mm.jpg'
                        ),
                    radius: 100.0,
                  ),
                )
              : const CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(
                    'assets/Logo.png',
                  ),
                  radius: 100.0,
                ),*/
          child: image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.file(
                    image!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ))
              : items.imagePath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        items.imagePath.toString(),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        'assets/Logo.png',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
          /*Hero(
            tag: items.artnrintern,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://wiplano.de/media/image/product/91860/md/landhausdiele-3-schicht-eiche-rustique-5g-zufaellige-oberflaechenveredelung-schwarz-gespachtelt-1100-x-190-mm.jpg'),
              radius: 100.0,
            ),
          ),*/
        ),
        /**Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
          child: items.image != null
              ? Hero(
            tag: items.id,
            child: CircleAvatar(
              backgroundImage: NetworkImage(items.image),
              radius: 100.0,
            ),
          )
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
        ),*/
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

  showwidget() {
    if (image != null) {
      Hero(
        tag: 1,
        child: CircleAvatar(
          backgroundImage: NetworkImage(image.toString()),
          radius: 100.0,
        ),
      );
    } else {
      Image.asset(
        'assets/Artenativ_Logo_Schwarz.png',
        width: 300,
        fit: BoxFit.cover,
      );
    }
    /*Hero(
      tag: items.artnrintern,
      child: CircleAvatar(
        backgroundImage: NetworkImage(
            'https://wiplano.de/media/image/product/91860/md/landhausdiele-3-schicht-eiche-rustique-5g-zufaellige-oberflaechenveredelung-schwarz-gespachtelt-1100-x-190-mm.jpg'),
        radius: 100.0,
      ),
    );*/

    /**if (items.image != null) {
      Hero(
        tag: items.id,
        child: CircleAvatar(
          backgroundImage: NetworkImage(items.image),
          radius: 100.0,
        ),
      );
    } else {
      Image.asset(
        'assets/Artenativ_Logo_Schwarz.png',
        width: 300,
        fit: BoxFit.cover,
      );
    }*/
  }

  void navigateToSignIn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginScreen(), fullscreenDialog: true));
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
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
