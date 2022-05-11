class AddartikelRequestModel {
  AddartikelRequestModel({
    required this.lieferant,
    required this.artikeltyp,
    required this.kategorie,
    required this.artnrlieferant,
    required this.lieferantandartikelnummer,
    required this.eancode,
    required this.material,
    required this.dimension,
    required this.haptik,
    required this.optik,
    required this.image,
  });
  late final String? lieferant;
  late final String? artikeltyp;
  late final String? kategorie;
  late final String? artnrlieferant;
  late final String? lieferantandartikelnummer;
  late final String? eancode;
  late final String? material;
  late final String? dimension;
  late final String? haptik;
  late final String? optik;
  late final String? image;

  AddartikelRequestModel.fromJson(Map<String, dynamic> json) {
    lieferant = json['lieferant'];
    artikeltyp = json['artikeltyp'];
    kategorie = json['kategorie'];
    artnrlieferant = json['artnrlieferant'];
    lieferantandartikelnummer = json['lieferantandartikelnummer'];
    eancode = json['eancode'];
    material = json['material'];
    dimension = json['dimension'];
    haptik = json['haptik'];
    optik = json['optik'];
    optik = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lieferant'] = lieferant;
    _data['artikeltyp'] = artikeltyp;
    _data['kategorie'] = kategorie;
    _data['artnrlieferant'] = artnrlieferant;
    _data['lieferantandartikelnummer'] = lieferantandartikelnummer;
    _data['eancode'] = eancode;
    _data['material'] = material;
    _data['dimension'] = dimension;
    _data['haptik'] = haptik;
    _data['optik'] = optik;
    _data['image'] = image;
    return _data;
  }
}
