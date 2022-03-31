library artenativ.globals;

import 'package:flutter/material.dart';

String? selectedHersteller;
String? selectedArtikeltyp;
String? selectedKategorie;
String? selectedBeanspruchung;
String? selectedVerfugbarkeit;
String? selectedMaterial;
String? artNrLieferantController;
String? artNrInternController;
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

String? einkauf;

List<String> artTypen = [];
List<String> kategorien = [];
List<String> materialien = [];

List<DropdownMenuItem<String>> herstellerListe = [
  const DropdownMenuItem(child: Text("- Lieferant auswählen -"), value: null),
  const DropdownMenuItem(child: Text("Admonter"), value: "Admonter"),
  const DropdownMenuItem(child: Text("Alu Plan"), value: "Alu Plan"),
  const DropdownMenuItem(child: Text("Amorim"), value: "Amorim"),
  const DropdownMenuItem(child: Text("Amtico"), value: "Amtico"),
  const DropdownMenuItem(child: Text("Bauwerk"), value: "Bauwerk"),
  const DropdownMenuItem(child: Text("Bärwolf"), value: "Bärwolf"),
  const DropdownMenuItem(
      child: Text("Becker Großgarten"), value: "Becker Großgarten"),
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
  const DropdownMenuItem(child: Text("Döllken"), value: "Döllken"),
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
  const DropdownMenuItem(child: Text("Götz Carl"), value: "Götz Carl"),
  const DropdownMenuItem(child: Text("Gunreben"), value: "Gunreben"),
  const DropdownMenuItem(child: Text("GW Tischler"), value: "GW Tischler"),
  const DropdownMenuItem(child: Text("Harrer"), value: "Harrer"),
  const DropdownMenuItem(child: Text("Hasit"), value: "Hasit"),
  const DropdownMenuItem(child: Text("Hocotimber"), value: "Hocotimber"),
  const DropdownMenuItem(child: Text("Hanke"), value: "Hanke"),
  const DropdownMenuItem(child: Text("Intercell"), value: "Intercell"),
  const DropdownMenuItem(child: Text("Janser"), value: "Janser"),
  const DropdownMenuItem(child: Text("Jasba"), value: "Jasba"),
  const DropdownMenuItem(child: Text("Jäger"), value: "Jäger"),
  const DropdownMenuItem(child: Text("JEP"), value: "JEP"),
  const DropdownMenuItem(child: Text("Jordan"), value: "Jordan"),
  const DropdownMenuItem(child: Text("Keskin"), value: "Keskin"),
  const DropdownMenuItem(child: Text("KGM"), value: "KGM"),
  const DropdownMenuItem(child: Text("KLB"), value: "KLB"),
  const DropdownMenuItem(child: Text("Koeber"), value: "Koeber"),
  const DropdownMenuItem(child: Text("Küblböck"), value: "Küblböck"),
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
  const DropdownMenuItem(child: Text("Schuhböcks"), value: "Schuhböcks"),
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
  const DropdownMenuItem(child: Text("Windmöller"), value: "Windmöller"),
  const DropdownMenuItem(child: Text("Würth"), value: "Würth"),
  const DropdownMenuItem(child: Text("ZEG"), value: "ZEG"),
];

List<DropdownMenuItem<String>> beanspruchungsKlassen = [
  const DropdownMenuItem(
      child: Text("- Beanspruchungsklasse auswählen -"), value: null),
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
      child: Text("- Verfügbarkeit auswählen -"), value: null),
  const DropdownMenuItem(child: Text("Lager"), value: "Lager"),
  const DropdownMenuItem(child: Text("Bestellung"), value: "Bestellung"),
];

List<String> admonter = [
  'Parkett',
];

List<String> aluPlan = [
  'Profile',
];

List<String> amorim = [
  'Beläge',
];

List<String> amtico = [
  'Beläge',
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
  'Werkzeuge und Zubehör',
];

List<String> denzel = [
  'Holz',
];

List<String> desso = [
  'Beläge',
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
  'Beläge',
];

List<String> dural = [
  'Profile',
];

List<String> effektivWerkzeug = [
  'Werkzeuge und Zubehör',
];

List<String> enia = [
  'Beläge',
];

List<String> ewifoam = [
  'Unterlagen',
];

List<String> fabromont = [
  'Beläge',
];

List<String> fetim = [
  'Parkett',
];

List<String> fuldaFilzfabrik = [
  'Beläge',
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
  'Beläge',
];

List<String> gerflor = [
  'Beläge',
];

List<String> gotzCarl = [
  'Holz',
];

List<String> gunreben = [
  'Holz',
];

List<String> gwTischler = [
  'Werkzeuge und Zubehör',
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
  'Werkzeuge und Zubehör',
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
  'Beläge',
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
  'Beläge',
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
  'Werkzeuge und Zubehör',
];

List<String> meisterWerke = [
  'Parkett',
];

List<String> objectflor = [
  'Beläge',
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
  'Beläge',
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
  'Beläge',
];

List<String> schlingelhoff = [
  'Werkzeuge und Zubehör',
];

List<String> schmittB = [
  'Parkett',
];

List<String> schuhboecks = [
  'Chemie',
];

List<String> schuller = [
  'Werkzeuge und Zubehör',
];

List<String> stauf = [
  'Chemie',
];

List<String> tagia = [
  'Fliesen',
];

List<String> tapesTools = [
  'Werkzeuge und Zubehör',
];

List<String> taxis = [
  'Fliesen',
];

List<String> tfd = [
  'Beläge',
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
  'Beläge',
];

List<String> vorwerk = [
  'Beläge',
];

List<String> wakol = [
  'Chemie',
];

List<String> weitzer = [
  'Parkett',
];

List<String> windmoeller = [
  'Beläge',
];

List<String> wuerth = [
  'Werkzeuge und Zubehör',
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
List<String> treppenKategorie = ['Blockstufe', 'Stufe mit Überstand'];

//Start Bau
List<String> bauKategorie = [
  'Dämmschüttung',
  'Estrich',
  'Isolierung',
  'Mörtel',
  'Putze'
];
//Start Bau Material
List<String> bauMaterial = ['Kein Material definiert'];
//End Bau Material
//End Bau

//Start Beläge
List<String> belaegeKategorie = [
  'Elastische Beläge',
  'Laminatboden',
  'Textile Beläge'
];
//Start Beläge Material
List<String> elastischeBelaegeMaterial = ['Vinyl'];
List<String> laminatbodenMaterial = ['Fliesenoptik', 'Holzoptik'];
List<String> textileBelaegeMaterial = [
  'Nadelfilz',
  'Schmutzfang',
  'Teppich',
  'Teppichboden'
];
//End Beläge Material
//End Beläge

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
List<String> gartenKategorie = ['Möbel', 'Terassendielen', 'Terassenplatten'];
//Start Garten Material
List<String> terassendielenMaterial = ['Holz', 'Poly', 'WPC'];
List<String> terassenplattenMaterial = ['Feinsteinzeug', 'Naturstein'];
List<String> moebelMaterial = ['Strandkörbe', 'Zäune Sichtschutz'];
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
  'Dämmstoffe',
  'Holzlasur',
  'Holzschutzfarbe',
  'Innenfarbe',
  'Parkettöle',
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
  'Dämmschüttung',
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
  'Eiche Systemlängen',
  'Räuchereiche',
  'Eiche Fixlängen',
  'weitere Holzarten'
];
List<String> holzartenMaterial = [
  'Ahorn',
  'Bambus',
  'Buche',
  'Cumaru',
  'Doussie',
  'Eiche',
  'Eiche gedämpft',
  'Esche',
  'Garapa',
  'Ipé (bras.Nussbaum)',
  'Iroko/Kambala',
  'Kirschbaum',
  'Nussbaum',
  'Räuchereiche',
  'Roteiche',
  'Wenige'
];
//End Parkett Material
//End Parkett

//Start Profile
List<String> profileKategorie = ['Bodenbeläge', 'Fliesen', 'Treppen'];
//Start Profile Material
List<String> bodenbelaegeMaterial = ['Abschluss', 'Übergang', 'Winkel'];
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
List<String> unterlagenKategorie = ['Abdichtung', 'Dämmung', 'Entkopplung'];
//Start Unterlagen Material
List<String> unterlagenMaterial = ['Kein Material definiert'];
//End Unterlagen Material
//End Unterlagen

//Start Werkzeuge und Zubehör
List<String> werkzeugeZubehoerKategorie = [
  'Abdeckmaterial',
  'Farbwalzen',
  'Klebebänder',
  'Pinsel & Bürsten',
  'Schleifmittel'
];
//Start Werkzeuge und Zubehör Material
List<String> werkzeugeZubehoerMaterial = ['Kein Material definiert'];
//End Werkzeuge und Zubehör Material
//End Werkzeuge und Zubehör
