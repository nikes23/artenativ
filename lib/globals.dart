library artenativ.globals;

import 'package:flutter/material.dart';

String? selectedHersteller;
String? selectedArtikeltyp;
String? selectedKategorie;

List<String> kategorien = [];

List<DropdownMenuItem<String>> herstellerListe = [
  const DropdownMenuItem(child: Text("- Hersteller auswählen -"), value: null),
  const DropdownMenuItem(child: Text("Weitzer"), value: "Weitzer"),
  const DropdownMenuItem(child: Text("Thede & Witte"), value: "Thede & Witte"),
  const DropdownMenuItem(child: Text("Admonter"), value: "Admonter"),
  const DropdownMenuItem(
      child: Text("Fetim Solidfloor"), value: "Fetim Solidfloor"),
  const DropdownMenuItem(child: Text("Schuller"), value: "Schuller"),
  const DropdownMenuItem(child: Text("Otto Silicon"), value: "Otto Silicon"),
  const DropdownMenuItem(child: Text("KWG"), value: "KWG"),
  const DropdownMenuItem(child: Text("Dural Prinz"), value: "Dural Prinz"),
  const DropdownMenuItem(child: Text("Herholz"), value: "Herholz"),
];

List<DropdownMenuItem<String>> artikeltypen = [
  const DropdownMenuItem(child: Text("- Artikeltyp auswählen -"), value: null),
  const DropdownMenuItem(child: Text("Designbeläge"), value: "Designbeläge"),
  const DropdownMenuItem(child: Text("Fliesen"), value: "Fliesen"),
  const DropdownMenuItem(child: Text("Parkett"), value: "Parkett"),
  const DropdownMenuItem(child: Text("Treppen"), value: "Treppen"),
];

List<String> fliesenKategorie = [
  'Feinsteinzeug',
  'Mosaik',
  'Sockelleisten',
  'Steingut'
];
List<String> parkettKategorie = [
  'Landhaus Dielen',
  'Massivholzdielen',
  'Mosaikparkett',
  'Stabparkett'
];
List<String> designKategorie = [
  'Korkboden',
  'Linoleum Boden',
  'Mineralischer Boden',
  'Vinylboden'
];
List<String> treppenKategorie = ['Blockstufe', 'Stufe mit Überstand'];
