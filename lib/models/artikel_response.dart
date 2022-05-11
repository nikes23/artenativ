import 'dart:convert';

ArtikelResponse artikelResponseJson(String str) =>
    ArtikelResponse.fromJson(json.decode(str));

class ArtikelResponse {
  ArtikelResponse({
    required this.message,
    required this.data,
  });
  late final String message;
  //late final Map<String, dynamic> data;
  late final String? data;

  ArtikelResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
    //data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
    //data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data;
    //_data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.lieferant,
    required this.artikeltyp,
    required this.kategorie,
    required this.artnrlieferant,
    required this.lieferantandartikelnummer,
    required this.eancode,
    required this.bezeichnung,
    required this.material,
    required this.dimension,
    required this.haptik,
    required this.optik,
    required this.sortierung,
    required this.vpeeinzeln,
    required this.einzelneinheit,
    required this.vpebund,
    required this.bundeinheit,
    required this.eigenschaft,
    required this.beanspruchungsklasse,
    required this.verfugbarkeit,
    required this.einkaufspreis,
    required this.verkaufspreiseins,
    required this.verkaufspreiszwei,
    required this.verkaufspreisdrei,
    required this.ausstellplatz,
  });
  late final String lieferant;
  late final String artikeltyp;
  late final String kategorie;
  late final String artnrlieferant;
  late final String lieferantandartikelnummer;
  late final String eancode;
  late final String bezeichnung;
  late final String material;
  late final String dimension;
  late final String haptik;
  late final String optik;
  late final String sortierung;
  late final String vpeeinzeln;
  late final String einzelneinheit;
  late final String vpebund;
  late final String bundeinheit;
  late final String eigenschaft;
  late final String beanspruchungsklasse;
  late final String verfugbarkeit;
  late final String einkaufspreis;
  late final String verkaufspreiseins;
  late final String verkaufspreiszwei;
  late final String verkaufspreisdrei;
  late final String ausstellplatz;

  Data.fromJson(Map<String, dynamic> json) {
    lieferant = json['lieferant'];
    artikeltyp = json['artikeltyp'];
    kategorie = json['kategorie'];
    artnrlieferant = json['artnrlieferant'];
    lieferantandartikelnummer = json['lieferantandartikelnummer'];
    eancode = json['eancode'];
    bezeichnung = json['bezeichnung'];
    material = json['material'];
    dimension = json['dimension'];
    haptik = json['haptik'];
    optik = json['optik'];
    sortierung = json['sortierung'];
    vpeeinzeln = json['vpeeinzeln'];
    einzelneinheit = json['einzelneinheit'];
    vpebund = json['vpebund'];
    bundeinheit = json['bundeinheit'];
    eigenschaft = json['eigenschaft'];
    beanspruchungsklasse = json['beanspruchungsklasse'];
    verfugbarkeit = json['verfugbarkeit'];
    einkaufspreis = json['einkaufspreis'];
    verkaufspreiseins = json['verkaufspreiseins'];
    verkaufspreiszwei = json['verkaufspreiszwei'];
    verkaufspreisdrei = json['verkaufspreisdrei'];
    ausstellplatz = json['ausstellplatz'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lieferant'] = lieferant;
    _data['artikeltyp'] = artikeltyp;
    _data['kategorie'] = kategorie;
    _data['artnrlieferant'] = artnrlieferant;
    _data['lieferantandartikelnummer'] = lieferantandartikelnummer;
    _data['eancode'] = eancode;
    _data['bezeichnung'] = bezeichnung;
    _data['material'] = material;
    _data['dimension'] = dimension;
    _data['haptik'] = haptik;
    _data['optik'] = optik;
    _data['sortierung'] = sortierung;
    _data['vpeeinzeln'] = vpeeinzeln;
    _data['einzelneinheit'] = einzelneinheit;
    _data['vpebund'] = vpebund;
    _data['bundeinheit'] = bundeinheit;
    _data['eigenschaft'] = eigenschaft;
    _data['beanspruchungsklasse'] = beanspruchungsklasse;
    _data['verfugbarkeit'] = verfugbarkeit;
    _data['einkaufspreis'] = einkaufspreis;
    _data['verkaufspreiseins'] = verkaufspreiseins;
    _data['verkaufspreiszwei'] = verkaufspreiszwei;
    _data['verkaufspreisdrei'] = verkaufspreisdrei;
    _data['ausstellplatz'] = ausstellplatz;
    return _data;
  }
}
