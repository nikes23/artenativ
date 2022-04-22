import 'dart:convert';

AddartikelResponseModel addArtikelResponseJson(String str) =>
    AddartikelResponseModel.fromJson(json.decode(str));

class AddartikelResponseModel {
  AddartikelResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final String? data;
  //late final Data? data;

  AddartikelResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
    //data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data!;
    //_data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.lieferant,
    required this.artikeltyp,
    required this.kategorie,
    required this.artnrlieferant,
    required this.eancode,
    required this.material,
    required this.dimension,
    required this.haptik,
    required this.optik,
    required this.artnrintern,
  });
  late final String? lieferant;
  late final String? artikeltyp;
  late final String? kategorie;
  late final String? artnrlieferant;
  late final String? eancode;
  late final String? material;
  late final String? dimension;
  late final String? haptik;
  late final String? optik;
  late final String? artnrintern;

  Data.fromJson(Map<String, dynamic> json) {
    lieferant = json['lieferant'];
    artikeltyp = json['artikeltyp'];
    kategorie = json['kategorie'];
    artnrlieferant = json['artnrlieferant'];
    eancode = json['eancode'];
    material = json['material'];
    dimension = json['dimension'];
    haptik = json['haptik'];
    optik = json['optik'];
    artnrintern = json['artnrintern'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lieferant'] = lieferant;
    _data['artikeltyp'] = artikeltyp;
    _data['kategorie'] = kategorie;
    _data['artnrlieferant'] = artnrlieferant;
    _data['eancode'] = eancode;
    _data['material'] = material;
    _data['dimension'] = dimension;
    _data['haptik'] = haptik;
    _data['optik'] = optik;
    _data['artnrintern'] = artnrintern;
    return _data;
  }
}
