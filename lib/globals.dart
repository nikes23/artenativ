library artenativ.globals;

import 'package:flutter/material.dart';

String? selectedHersteller;
String? selectedArtikeltyp;
String? selectedKategorie;
String? selectedBeanspruchung;
String? selectedVerfugbarkeit;
String? selectedMaterial;
String? selectedEinzelnVerpackungseinheiten;
String? selectedBundVerpackungseinheiten;
String? artNrLieferantController;
String eanCodeGlobal = '';
String? bezeichnungController;
String? dimensionController;
String? haptikController;
String? optikController;
String? sortierungController;
String? vpeEinzelnController;
String? vpeBundController;
String? eigenschaftController;
String? einkaufspreisController;
String? verkaufspreisEinsController;
String? verkaufspreisZweiController;
String? verkaufspreisDreiController;
String? verkaufspreisMwStController;
String? ausstellungsplatzController;
int? artNrIntern;
int? artNrInternPlus;
String? artNrInternString;
String? qrcodeResult;
String? barcodeResult;

//Find One Article
String? findLieferant;
String? findArtikeltyp;
String? findKategorie;
String? findArtNrLieferant;
String? findLieferantandartikelnummer;
String findArtNrIntern = '';
String? findEanCode;
String? findBezeichnung;
String? findMaterial;
String? findDimension;
String? findHaptik;
String? findOptik;
String? findSortierung;
String? findVpeEinzeln;
String? findVpeBund;
String? findEinzelnVerpackungseinheiten;
String? findBundVerpackungseinheiten;
String? findEigenschaft;
String? findBeanspruchungsklasse;
String? findVerfugbarkeit;
String? findEinkaufspreis;
String? findVerkaufspreisEins;
String? findVerkaufspreisZwei;
String? findVerkaufspreisDrei;
String? findVerkaufspreisMWST;
String? findAusstellplatz;
String? findImageName;
String? findImagePath;

String printerIp = '192.168.188.115';
int printerPort = 9500;

String? einkauf;
String? vkdreicontroller;

double mwstCalculate = 0.0;
String? mwstResult;

List<String> artTypen = [];
List<String> kategorien = [];
List<String> materialien = [];

List<DropdownMenuItem<String>> herstellerListe = [
  const DropdownMenuItem(child: Text("- Lieferant ausw??hlen -"), value: null),
  const DropdownMenuItem(child: Text("Admonter"), value: "Admonter"),
  const DropdownMenuItem(child: Text("Alu Plan"), value: "Alu Plan"),
  const DropdownMenuItem(child: Text("Amorim"), value: "Amorim"),
  const DropdownMenuItem(child: Text("Amtico"), value: "Amtico"),
  const DropdownMenuItem(child: Text("Artenativ"), value: "Artenativ"),
  const DropdownMenuItem(child: Text("Bauwerk"), value: "Bauwerk"),
  const DropdownMenuItem(child: Text("B??rwolf"), value: "B??rwolf"),
  const DropdownMenuItem(
      child: Text("Becker Gro??garten"), value: "Becker Gro??garten"),
  const DropdownMenuItem(child: Text("Belopa"), value: "Belopa"),
  const DropdownMenuItem(child: Text("Biehler"), value: "Biehler"),
  const DropdownMenuItem(child: Text("Brich"), value: "Brich"),
  const DropdownMenuItem(child: Text("BTI"), value: "BTI"),
  const DropdownMenuItem(child: Text("Buchner"), value: "Buchner"),
  const DropdownMenuItem(
      child: Text("Burger Holzzentrum"), value: "Burger Holzzentrum"),
  const DropdownMenuItem(child: Text("Christ"), value: "Christ"),
  const DropdownMenuItem(child: Text("Climacell"), value: "Climacell"),
  const DropdownMenuItem(child: Text("Dahm"), value: "Dahm"),
  const DropdownMenuItem(child: Text("Denzel"), value: "Denzel"),
  const DropdownMenuItem(child: Text("Desso"), value: "Desso"),
  const DropdownMenuItem(child: Text("Dekora"), value: "Dekora"),
  const DropdownMenuItem(child: Text("D??llken"), value: "D??llken"),
  const DropdownMenuItem(child: Text("Dr. Schutz"), value: "Dr. Schutz"),
  const DropdownMenuItem(child: Text("Dura"), value: "Dura"),
  const DropdownMenuItem(child: Text("Dural"), value: "Dural"),
  const DropdownMenuItem(
      child: Text("Effektiv Werkzeug"), value: "Effektiv Werkzeug"),
  const DropdownMenuItem(child: Text("Enia"), value: "Enia"),
  const DropdownMenuItem(child: Text("Ewifoam"), value: "Ewifoam"),
  const DropdownMenuItem(child: Text("Fabromont"), value: "Fabromont"),
  const DropdownMenuItem(child: Text("Fetim"), value: "Fetim"),
  const DropdownMenuItem(
      child: Text("Fulda Filzfabrik"), value: "Fulda Filzfabrik"),
  const DropdownMenuItem(child: Text("Futura Floors"), value: "Futura Floors"),
  const DropdownMenuItem(child: Text("Floors 4ever"), value: "Floors 4ever"),
  const DropdownMenuItem(
      child: Text("Forbo Eurocool"), value: "Forbo Eurocool"),
  const DropdownMenuItem(
      child: Text("Forbo Flooring"), value: "Forbo Flooring"),
  const DropdownMenuItem(child: Text("Gerflor"), value: "Gerflor"),
  const DropdownMenuItem(child: Text("G??tz Carl"), value: "G??tz Carl"),
  const DropdownMenuItem(child: Text("Gunreben"), value: "Gunreben"),
  const DropdownMenuItem(child: Text("GW Tischler"), value: "GW Tischler"),
  const DropdownMenuItem(child: Text("Harrer"), value: "Harrer"),
  const DropdownMenuItem(child: Text("Hasit"), value: "Hasit"),
  const DropdownMenuItem(child: Text("Hocotimber"), value: "Hocotimber"),
  const DropdownMenuItem(child: Text("Hanke"), value: "Hanke"),
  const DropdownMenuItem(child: Text("Intercell"), value: "Intercell"),
  const DropdownMenuItem(child: Text("Janser"), value: "Janser"),
  const DropdownMenuItem(child: Text("Jasba"), value: "Jasba"),
  const DropdownMenuItem(child: Text("J??ger"), value: "J??ger"),
  const DropdownMenuItem(child: Text("JEP"), value: "JEP"),
  const DropdownMenuItem(child: Text("Jordan"), value: "Jordan"),
  const DropdownMenuItem(child: Text("Keskin"), value: "Keskin"),
  const DropdownMenuItem(child: Text("KGM"), value: "KGM"),
  const DropdownMenuItem(child: Text("KLB"), value: "KLB"),
  const DropdownMenuItem(child: Text("Koeber"), value: "Koeber"),
  const DropdownMenuItem(child: Text("K??blb??ck"), value: "K??blb??ck"),
  const DropdownMenuItem(child: Text("KWG"), value: "KWG"),
  const DropdownMenuItem(child: Text("Martin Meier"), value: "Martin Meier"),
  const DropdownMenuItem(child: Text("Mayer Bauz"), value: "Mayer Bauz"),
  const DropdownMenuItem(child: Text("Murexin"), value: "Murexin"),
  const DropdownMenuItem(child: Text("NBO"), value: "NBO"),
  const DropdownMenuItem(child: Text("Neuhofer"), value: "Neuhofer"),
  const DropdownMenuItem(child: Text("Norwork"), value: "Norwork"),
  const DropdownMenuItem(child: Text("Meister Werke"), value: "Meister Werke"),
  const DropdownMenuItem(child: Text("Objectflor"), value: "Objectflor"),
  const DropdownMenuItem(child: Text("Ochs"), value: "Ochs"),
  const DropdownMenuItem(child: Text("Oster"), value: "Oster"),
  const DropdownMenuItem(child: Text("Otto Chemie"), value: "Otto Chemie"),
  const DropdownMenuItem(child: Text("Pallmann"), value: "Pallmann"),
  const DropdownMenuItem(child: Text("Parigiani"), value: "Parigiani"),
  const DropdownMenuItem(child: Text("Pfahler"), value: "Pfahler"),
  const DropdownMenuItem(child: Text("PNZ"), value: "PNZ"),
  const DropdownMenuItem(child: Text("Prinz Carl"), value: "Prinz Carl"),
  const DropdownMenuItem(
      child: Text("Project Floors"), value: "Project Floors"),
  const DropdownMenuItem(child: Text("Raab Karcher"), value: "Raab Karcher"),
  const DropdownMenuItem(child: Text("Reincke"), value: "Reincke"),
  const DropdownMenuItem(child: Text("Repack"), value: "Repack"),
  const DropdownMenuItem(child: Text("Scheffold"), value: "Scheffold"),
  const DropdownMenuItem(child: Text("Schimmer"), value: "Schimmer"),
  const DropdownMenuItem(child: Text("Schlau"), value: "Schlau"),
  const DropdownMenuItem(child: Text("Schlingelhoff"), value: "Schlingelhoff"),
  const DropdownMenuItem(child: Text("Schmitt B"), value: "Schmitt B"),
  const DropdownMenuItem(child: Text("Schuhb??cks"), value: "Schuhb??cks"),
  const DropdownMenuItem(child: Text("Schuller"), value: "Schuller"),
  const DropdownMenuItem(child: Text("Solum"), value: "Solum"),
  const DropdownMenuItem(child: Text("Sonat"), value: "Sonat"),
  const DropdownMenuItem(child: Text("Sonnenpartner"), value: "Sonnenpartner"),
  const DropdownMenuItem(child: Text("Stauf"), value: "Stauf"),
  const DropdownMenuItem(child: Text("Tagia"), value: "Tagia"),
  const DropdownMenuItem(child: Text("Tapes Tools"), value: "Tapes Tools"),
  const DropdownMenuItem(child: Text("Taxis"), value: "Taxis"),
  const DropdownMenuItem(child: Text("TFD"), value: "TFD"),
  const DropdownMenuItem(child: Text("Thede Witte"), value: "Thede Witte"),
  const DropdownMenuItem(child: Text("Templer"), value: "Templer"),
  const DropdownMenuItem(child: Text("Thalhofer"), value: "Thalhofer"),
  const DropdownMenuItem(child: Text("Upofloor"), value: "Upofloor"),
  const DropdownMenuItem(child: Text("Vorwerk"), value: "Vorwerk"),
  const DropdownMenuItem(child: Text("Wakol"), value: "Wakol"),
  const DropdownMenuItem(child: Text("Weitzer"), value: "Weitzer"),
  const DropdownMenuItem(child: Text("Windm??ller"), value: "Windm??ller"),
  const DropdownMenuItem(child: Text("W??rth"), value: "W??rth"),
  const DropdownMenuItem(child: Text("ZEG"), value: "ZEG"),
];

List<DropdownMenuItem<String>> beanspruchungsKlassen = [
  const DropdownMenuItem(
      child: Text("- Beanspruchungsklasse ausw??hlen -"), value: null),
  const DropdownMenuItem(child: Text("0"), value: "0"),
  const DropdownMenuItem(child: Text("21"), value: "21"),
  const DropdownMenuItem(child: Text("22"), value: "22"),
  const DropdownMenuItem(child: Text("23"), value: "23"),
  const DropdownMenuItem(child: Text("31"), value: "31"),
  const DropdownMenuItem(child: Text("32"), value: "32"),
  const DropdownMenuItem(child: Text("33"), value: "33"),
  const DropdownMenuItem(child: Text("41"), value: "41"),
  const DropdownMenuItem(child: Text("42"), value: "42"),
  const DropdownMenuItem(child: Text("43"), value: "43"),
];

List<DropdownMenuItem<String>> verfugbarkeit = [
  const DropdownMenuItem(
      child: Text("- Verf??gbarkeit ausw??hlen -"), value: null),
  const DropdownMenuItem(child: Text("Lager"), value: "Lager"),
  const DropdownMenuItem(child: Text("Bestellung"), value: "Bestellung"),
];

List<DropdownMenuItem<String>> verpackungseinheiten = [
  const DropdownMenuItem(
      child: Text("- Einheit ausw??hlen -", style: TextStyle(fontSize: 14.0)),
      value: null),
  const DropdownMenuItem(child: Text("Ampulle(n)"), value: "Ampulle(n)"),
  const DropdownMenuItem(child: Text("Becher"), value: "Becher"),
  const DropdownMenuItem(child: Text("Beh??lter"), value: "Beh??lter"),
  const DropdownMenuItem(child: Text("Beutel"), value: "Beutel"),
  const DropdownMenuItem(child: Text("Blister"), value: "Blister"),
  const DropdownMenuItem(child: Text("Box(en)"), value: "Box(en)"),
  const DropdownMenuItem(child: Text("Container"), value: "Container"),
  const DropdownMenuItem(child: Text("Dose(n)"), value: "Dose(n)"),
  const DropdownMenuItem(child: Text("Eimer"), value: "Eimer"),
  const DropdownMenuItem(child: Text("Einheit"), value: "Einheit"),
  const DropdownMenuItem(child: Text("Einsatz"), value: "Einsatz"),
  const DropdownMenuItem(child: Text("Fass/F??sser"), value: "Fass/F??sser"),
  const DropdownMenuItem(child: Text("Flasche(n)"), value: "Flasche(n)"),
  const DropdownMenuItem(child: Text("Folie(n)"), value: "Folie(n)"),
  const DropdownMenuItem(child: Text("Gebinde"), value: "Gebinde"),
  const DropdownMenuItem(child: Text("Kanister"), value: "Kanister"),
  const DropdownMenuItem(child: Text("Karton(s)"), value: "Karton(s)"),
  const DropdownMenuItem(child: Text("Kartusche(n)"), value: "Kartusche(n)"),
  const DropdownMenuItem(child: Text("Kasten/K??sten"), value: "Kasten/K??sten"),
  const DropdownMenuItem(child: Text("Kilogramm"), value: "Kilogramm"),
  const DropdownMenuItem(child: Text("Kiste(n)"), value: "Kiste(n)"),
  const DropdownMenuItem(child: Text("Korb/K??rbe"), value: "Korb/K??rbe"),
  const DropdownMenuItem(child: Text("Kubikmeter"), value: "Kubikmeter"),
  const DropdownMenuItem(
      child: Text("Laufende Meter"), value: "Laufende Meter"),
  const DropdownMenuItem(child: Text("Liter"), value: "Liter"),
  const DropdownMenuItem(child: Text("Paar"), value: "Paar"),
  const DropdownMenuItem(child: Text("Packung(en)"), value: "Packung(en)"),
  const DropdownMenuItem(child: Text("Paket(e)"), value: "Paket(e)"),
  const DropdownMenuItem(child: Text("Palette(n)"), value: "Palette(n)"),
  const DropdownMenuItem(child: Text("Pauschal"), value: "Pauschal"),
  const DropdownMenuItem(child: Text("Quadratmeter"), value: "Quadratmeter"),
  const DropdownMenuItem(child: Text("Rolle(n)"), value: "Rolle(n)"),
  const DropdownMenuItem(child: Text("Sack/S??cke"), value: "Sack/S??cke"),
  const DropdownMenuItem(child: Text("Schachtel(n)"), value: "Schachtel(n)"),
  const DropdownMenuItem(child: Text("Set(s)"), value: "Set(s)"),
  const DropdownMenuItem(child: Text("Spule(n)"), value: "Spule(n)"),
  const DropdownMenuItem(child: Text("St??ck(e)"), value: "St??ck(e)"),
  const DropdownMenuItem(child: Text("Stufe(n)"), value: "Stufe(n)"),
  const DropdownMenuItem(child: Text("Tonne(n)"), value: "Tonne(n)"),
  const DropdownMenuItem(child: Text("Tube(n)"), value: "Tube(n)"),
  const DropdownMenuItem(child: Text("T??te(n)"), value: "T??te(n)"),
  const DropdownMenuItem(
      child: Text("Verkaufspackung(en)"), value: "Verkaufspackung(en)"),
];

List<DropdownMenuItem<String>> verpackungseinheitenBund = [
  const DropdownMenuItem(
      child: Text("- Einheit ausw??hlen -", style: TextStyle(fontSize: 14.0)),
      value: null),
  const DropdownMenuItem(child: Text("Ampulle(n)"), value: "Ampulle(n)"),
  const DropdownMenuItem(child: Text("Becher"), value: "Becher"),
  const DropdownMenuItem(child: Text("Beh??lter"), value: "Beh??lter"),
  const DropdownMenuItem(child: Text("Beutel"), value: "Beutel"),
  const DropdownMenuItem(child: Text("Blister"), value: "Blister"),
  const DropdownMenuItem(child: Text("Box(en)"), value: "Box(en)"),
  const DropdownMenuItem(child: Text("Container"), value: "Container"),
  const DropdownMenuItem(child: Text("Dose(n)"), value: "Dose(n)"),
  const DropdownMenuItem(child: Text("Eimer"), value: "Eimer"),
  const DropdownMenuItem(child: Text("Einheit"), value: "Einheit"),
  const DropdownMenuItem(child: Text("Einsatz"), value: "Einsatz"),
  const DropdownMenuItem(child: Text("Fass/F??sser"), value: "Fass/F??sser"),
  const DropdownMenuItem(child: Text("Flasche(n)"), value: "Flasche(n)"),
  const DropdownMenuItem(child: Text("Folie(n)"), value: "Folie(n)"),
  const DropdownMenuItem(child: Text("Gebinde"), value: "Gebinde"),
  const DropdownMenuItem(child: Text("Kanister"), value: "Kanister"),
  const DropdownMenuItem(child: Text("Karton(s)"), value: "Karton(s)"),
  const DropdownMenuItem(child: Text("Kartusche(n)"), value: "Kartusche(n)"),
  const DropdownMenuItem(child: Text("Kasten/K??sten"), value: "Kasten/K??sten"),
  const DropdownMenuItem(child: Text("Kilogramm"), value: "Kilogramm"),
  const DropdownMenuItem(child: Text("Kiste(n)"), value: "Kiste(n)"),
  const DropdownMenuItem(child: Text("Korb/K??rbe"), value: "Korb/K??rbe"),
  const DropdownMenuItem(child: Text("Kubikmeter"), value: "Kubikmeter"),
  const DropdownMenuItem(
      child: Text("Laufende Meter"), value: "Laufende Meter"),
  const DropdownMenuItem(child: Text("Liter"), value: "Liter"),
  const DropdownMenuItem(child: Text("Paar"), value: "Paar"),
  const DropdownMenuItem(child: Text("Packung(en)"), value: "Packung(en)"),
  const DropdownMenuItem(child: Text("Paket(e)"), value: "Paket(e)"),
  const DropdownMenuItem(child: Text("Palette(n)"), value: "Palette(n)"),
  const DropdownMenuItem(child: Text("Pauschal"), value: "Pauschal"),
  const DropdownMenuItem(child: Text("Quadratmeter"), value: "Quadratmeter"),
  const DropdownMenuItem(child: Text("Rolle(n)"), value: "Rolle(n)"),
  const DropdownMenuItem(child: Text("Sack/S??cke"), value: "Sack/S??cke"),
  const DropdownMenuItem(child: Text("Schachtel(n)"), value: "Schachtel(n)"),
  const DropdownMenuItem(child: Text("Set(s)"), value: "Set(s)"),
  const DropdownMenuItem(child: Text("Spule(n)"), value: "Spule(n)"),
  const DropdownMenuItem(child: Text("St??ck(e)"), value: "St??ck(e)"),
  const DropdownMenuItem(child: Text("Stufe(n)"), value: "Stufe(n)"),
  const DropdownMenuItem(child: Text("Tonne(n)"), value: "Tonne(n)"),
  const DropdownMenuItem(child: Text("Tube(n)"), value: "Tube(n)"),
  const DropdownMenuItem(child: Text("T??te(n)"), value: "T??te(n)"),
  const DropdownMenuItem(
      child: Text("Verkaufspackung(en)"), value: "Verkaufspackung(en)"),
];

List<String> all = [
  'Bau',
  'Bel??ge',
  'Chemie',
  'Fliesen',
  'Garten',
  'Glaserei',
  'Holz',
  'Metallbau',
  'Naturbaustoffe',
  'Parkett',
  'Profile',
  'Schreinerei',
  'Sockelleisten',
  'Stein',
  'Unterlagen',
  'Werkzeuge und Zubeh??r'
];

List<String> admonter = [
  'Parkett',
];

List<String> aluPlan = [
  'Profile',
];

List<String> amorim = [
  'Bel??ge',
];

List<String> amtico = [
  'Bel??ge',
];

List<String> bauwerk = [
  'Parkett',
];

List<String> baerwolf = [
  'Fliesen',
];

List<String> becker = [
  'Parkett',
];

List<String> belopa = [
  'Parkett',
];

List<String> biehler = [
  'Schreinerei',
];

List<String> brich = [
  'Glaserei',
];

List<String> bti = [
  'Chemie',
];

List<String> buchner = [
  'Metallbau',
];

List<String> burgerHolz = [
  'Holz',
];

List<String> christ = [
  'Fliesen',
];

List<String> climacell = [
  'Naturbaustoffe',
];

List<String> dahm = [
  'Werkzeuge und Zubeh??r',
];

List<String> denzel = [
  'Holz',
];

List<String> desso = [
  'Bel??ge',
];

List<String> dekora = [
  'Parkett',
];

List<String> doellken = [
  'Sockelleisten',
];

List<String> schutz = [
  'Chemie',
];

List<String> dura = [
  'Bel??ge',
];

List<String> dural = [
  'Profile',
];

List<String> effektivWerkzeug = [
  'Werkzeuge und Zubeh??r',
];

List<String> enia = [
  'Bel??ge',
];

List<String> ewifoam = [
  'Unterlagen',
];

List<String> fabromont = [
  'Bel??ge',
];

List<String> fetim = [
  'Parkett',
];

List<String> fuldaFilzfabrik = [
  'Bel??ge',
];

List<String> futuraFloors = [
  'Parkett',
];

List<String> floorsEver = [
  'Parkett',
];

List<String> forboEurocool = [
  'Chemie',
];

List<String> forboFlooring = [
  'Bel??ge',
];

List<String> gerflor = [
  'Bel??ge',
];

List<String> gotzCarl = [
  'Holz',
];

List<String> gunreben = [
  'Holz',
];

List<String> gwTischler = [
  'Werkzeuge und Zubeh??r',
];

List<String> harrer = [
  'Fliesen',
];

List<String> hasit = [
  'Chemie',
];

List<String> hocotimber = [
  'Sockelleisten',
];

List<String> hanke = [
  'Schreinerei',
];

List<String> intercell = [
  'Naturbaustoffe',
];

List<String> janser = [
  'Werkzeuge und Zubeh??r',
];

List<String> jasba = [
  'Fliesen',
];

List<String> jaeger = [
  'Chemie',
];

List<String> jep = [
  'Parkett',
];

List<String> jordan = [
  'Bel??ge',
];

List<String> keskin = [
  'Fliesen',
];

List<String> kgm = [
  'Sockelleisten',
];

List<String> klb = [
  'Chemie',
];

List<String> koeber = [
  'Fliesen',
];

List<String> kueblboeck = [
  'Fliesen',
];

List<String> kwg = [
  'Bel??ge',
];

List<String> martinMeier = [
  'Bau',
];

List<String> mayerBauz = [
  'Bau',
];

List<String> murexin = [
  'Chemie',
];

List<String> nbo = [
  'Naturbaustoffe',
];

List<String> neuhofer = [
  'Sockelleisten',
];

List<String> norwork = [
  'Werkzeuge und Zubeh??r',
];

List<String> meisterWerke = [
  'Parkett',
];

List<String> objectflor = [
  'Bel??ge',
];

List<String> ochs = [
  'Bau',
];

List<String> oster = [
  'Parkett',
];

List<String> ottoChemie = [
  'Chemie',
];

List<String> pallmann = [
  'Chemie',
];

List<String> parigiani = [
  'Garten',
];

List<String> scheffold = [
  'Parkett',
];

List<String> solum = [
  'Parkett',
];

List<String> pfahler = [
  'Holz',
];

List<String> pnz = [
  'Chemie',
];

List<String> prinzCarl = [
  'Profile',
];

List<String> projectFloors = [
  'Bel??ge',
];

List<String> raabKarcher = [
  'Fliesen',
];

List<String> reincke = [
  'Naturbaustoffe',
];

List<String> repack = [
  'Profile',
];

List<String> sonat = [
  'Fliesen',
];

List<String> sonnenpartner = [
  'Garten',
];

List<String> schimmer = [
  'Bau',
];

List<String> schlau = [
  'Bel??ge',
];

List<String> schlingelhoff = [
  'Werkzeuge und Zubeh??r',
];

List<String> schmittB = [
  'Parkett',
];

List<String> schuhboecks = [
  'Chemie',
];

List<String> schuller = [
  'Werkzeuge und Zubeh??r',
];

List<String> stauf = [
  'Chemie',
];

List<String> tagia = [
  'Fliesen',
];

List<String> tapesTools = [
  'Werkzeuge und Zubeh??r',
];

List<String> taxis = [
  'Fliesen',
];

List<String> tfd = [
  'Bel??ge',
];

List<String> thedeWitte = [
  'Parkett',
];

List<String> templer = [
  'Stein',
];

List<String> thalhofer = [
  'Holz',
];

List<String> upofloor = [
  'Bel??ge',
];

List<String> vorwerk = [
  'Bel??ge',
];

List<String> wakol = [
  'Chemie',
];

List<String> weitzer = [
  'Parkett',
];

List<String> windmoeller = [
  'Bel??ge',
];

List<String> wuerth = [
  'Werkzeuge und Zubeh??r',
];

List<String> zeg = [
  'Holz',
];

List<String> designKategorie = [
  'Korkboden',
  'Linoleum Boden',
  'Mineralischer Boden',
  'Vinylboden'
];
List<String> treppenKategorie = ['Blockstufe', 'Stufe mit ??berstand'];

//Start Bau
List<String> bauKategorie = [
  'D??mmsch??ttung',
  'Estrich',
  'Isolierung',
  'M??rtel',
  'Putze'
];
//Start Bau Material
List<String> bauMaterial = ['Kein Material definiert'];
//End Bau Material
//End Bau

//Start Bel??ge
List<String> belaegeKategorie = [
  'Elastische Bel??ge',
  'Laminatboden',
  'Textile Bel??ge'
];
//Start Bel??ge Material
List<String> elastischeBelaegeMaterial = ['Vinyl'];
List<String> laminatbodenMaterial = ['Fliesenoptik', 'Holzoptik'];
List<String> textileBelaegeMaterial = [
  'Nadelfilz',
  'Schmutzfang',
  'Teppich',
  'Teppichboden'
];
//End Bel??ge Material
//End Bel??ge

//Start Chemie
List<String> chemieKategorie = [
  'Dichtstoffe',
  'Klebstoffe',
  'Lackspray',
  'Parkettlacke',
  'Reinigungs- und Pflegemittel',
  'Untergrund',
  'Verbundabdichtung'
];
//Start Chemie Material
List<String> untergrundMaterial = ['Haftgrund'];
List<String> klebstoffeMaterial = ['Parkett'];
List<String> dichtstoffeMaterial = ['Parkett'];
List<String> verbundabdichtungMaterial = ['Fliese'];
List<String> chemieMaterial = ['Kein Material definiert'];
//End Chemie Material
//End Chemie

//Start Fliesen
List<String> fliesenKategorie = ['Feinsteinzeug', 'Naturstein', 'Steinzeug'];
//Start Fliesen Material
List<String> fliesenMaterial = ['Kein Material definiert'];
//End Fliesen Material
//End Fliesen

//Start Garten
List<String> gartenKategorie = ['M??bel', 'Terassendielen', 'Terassenplatten'];
//Start Garten Material
List<String> terassendielenMaterial = ['Holz', 'Poly', 'WPC'];
List<String> terassenplattenMaterial = ['Feinsteinzeug', 'Naturstein'];
List<String> moebelMaterial = ['Strandk??rbe', 'Z??une Sichtschutz'];
//End Garten Material
//End Garten

//Start Holz
List<String> holzKategorie = ['Hobelware', 'Plattenwerkstoffe', 'Schnittholz'];
//Start Holz Material
List<String> holzMaterial = ['Kein Material definiert'];
List<String> plattenwerkstoffeMaterial = ['OSB Platten', 'Spanplatten'];
//End Holz Material
//End Holz

//Start Naturbaustoffe
List<String> naturbaustoffeKategorie = [
  'D??mmstoffe',
  'Holzlasur',
  'Holzschutzfarbe',
  'Innenfarbe',
  'Parkett??le',
  'Pflegemittel',
  'Putze'
];
//Start Naturbaustoffe Material
List<String> innenfarbeMaterial = [
  'Kalkfarbe',
  'Lehmfarbe',
  'Naturharzdispersion',
  'Silikatfarbe',
  'Silikat-Lehmfarbe'
];
List<String> putzeNaturbaustoffeMaterial = [
  'Lehmbauplatten',
  'Lehmputze',
  'Lehmsteine'
];
List<String> naturbaustoffeMaterial = ['Kein Material definiert'];
List<String> daemmstoffeMaterial = [
  'D??mmsch??ttung',
  'Hanf',
  'Holzfaser',
  'Jute',
  'Kork',
  'Zellulose'
];
//End Naturbaustoffe Material
//End Naturbaustoffe

//Start Parkett
List<String> parkettKategorie = [
  'Fertigparkett',
  'Holzarten',
  'Massivholzdielen',
  'Massivparkett'
];

//Start Parkett Material
List<String> massivparkettMaterial = [
  'Hochkantlamelle',
  'Holzpflaster Hirnholz',
  'Mosaikparkett',
  'Stabparkett',
  'Tafelboden'
];
List<String> fertigparkettMaterial = [
  'A-Park 2-Schicht',
  'A-Park Maxi 2-Schicht',
  'A-Park Maxi XL 2-Schicht',
  'Landhausdiele 3-Schicht',
  'Schlossdiele 3-Schicht'
];
List<String> massivholzdielenMaterial = [
  'Eiche Systeml??ngen',
  'R??uchereiche',
  'Eiche Fixl??ngen',
  'weitere Holzarten'
];
List<String> holzartenMaterial = [
  'Ahorn',
  'Bambus',
  'Buche',
  'Cumaru',
  'Doussie',
  'Eiche',
  'Eiche ged??mpft',
  'Esche',
  'Garapa',
  'Ip?? (bras.Nussbaum)',
  'Iroko/Kambala',
  'Kirschbaum',
  'Nussbaum',
  'R??uchereiche',
  'Roteiche',
  'Wenige'
];
//End Parkett Material
//End Parkett

//Start Profile
List<String> profileKategorie = ['Bodenbel??ge', 'Fliesen', 'Treppen'];
//Start Profile Material
List<String> bodenbelaegeMaterial = ['Abschluss', '??bergang', 'Winkel'];
List<String> fliesenProfileMaterial = ['Abschluss', 'Treppenstufen'];
List<String> treppenMaterial = ['Blockstufe Holz'];
//End Profile Material
//End Profile

//Start Sockelleisten
List<String> sockelleistenKategorie = [
  'Holz furniert',
  'Holz massiv',
  'Holz ummantelt',
  'Kunststoff',
  'Metall'
];
//Start Sockelleisten Material
List<String> sockelleistenMaterial = ['Kein Material definiert'];
//End Sockelleisten Material
//End Sockelleisten

//Start keine Kategorie & Material definiert
List<String> keineKategorie = ['Keine Kategorie definiert'];
List<String> keinMaterial = ['Kein Material definiert'];
//End keine Kategorie & Material definiert

//Start Unterlagen
List<String> unterlagenKategorie = ['Abdichtung', 'D??mmung', 'Entkopplung'];
//Start Unterlagen Material
List<String> unterlagenMaterial = ['Kein Material definiert'];
//End Unterlagen Material
//End Unterlagen

//Start Werkzeuge und Zubeh??r
List<String> werkzeugeZubehoerKategorie = [
  'Abdeckmaterial',
  'Farbwalzen',
  'Klebeb??nder',
  'Pinsel & B??rsten',
  'Schleifmittel'
];
//Start Werkzeuge und Zubeh??r Material
List<String> werkzeugeZubehoerMaterial = ['Kein Material definiert'];
//End Werkzeuge und Zubeh??r Material
//End Werkzeuge und Zubeh??r
