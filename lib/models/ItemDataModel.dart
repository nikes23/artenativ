class ItemDataModel {
  String id = '';
  String lieferant = '',
      artikeltyp = '',
      kategorie = '',
      artikelnummerlieferant = '',
      artikelnummerintern = '',
      eanbarcode = '',
      material = '',
      dimension = '',
      haptik = '',
      optik = '',
      image = '';

  ItemDataModel(
      this.id,
      this.lieferant,
      this.artikeltyp,
      this.kategorie,
      this.artikelnummerlieferant,
      this.artikelnummerintern,
      this.eanbarcode,
      this.material,
      this.dimension,
      this.haptik,
      this.optik,
      this.image);

  ItemDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lieferant = json['lieferant'];
    artikeltyp = json['artikeltyp'];
    kategorie = json['kategorie'];
    artikelnummerlieferant = json['artikelnummerlieferant'];
    artikelnummerintern = json['artikelnummerintern'];
    eanbarcode = json['eanbarcode'];
    material = json['material'];
    dimension = json['dimension'];
    haptik = json['haptik'];
    optik = json['optik'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lieferant'] = this.lieferant;
    data['artikeltyp'] = this.artikeltyp;
    data['kategorie'] = this.kategorie;
    data['artikelnummerlieferant'] = this.artikelnummerlieferant;
    data['artikelnummerintern'] = this.artikelnummerintern;
    data['eanbarcode'] = this.eanbarcode;
    data['material'] = this.material;
    data['dimension'] = this.dimension;
    data['haptik'] = this.haptik;
    data['optik'] = this.optik;
    return data;
  }
}
