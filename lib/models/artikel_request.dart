class Artikel {
  Artikel({
    required this.lieferant,
    required this.artikeltyp,
    required this.kategorie,
    required this.artnrlieferant,
    this.lieferantandartikelnummer,
    required this.artnrintern,
    required this.eancode,
    this.bezeichnung,
    required this.material,
    required this.dimension,
    required this.haptik,
    required this.optik,
    this.sortierung,
    this.vpeeinzeln,
    this.einzelneinheit,
    this.vpebund,
    this.bundeinheit,
    this.eigenschaft,
    this.beanspruchungsklasse,
    this.verfugbarkeit,
    this.einkaufspreis,
    this.verkaufspreiseins,
    this.verkaufspreiszwei,
    this.verkaufspreisdrei,
    this.ausstellplatz,
    this.imageName,
    this.imagePath,
  });
  final String lieferant;
  final String artikeltyp;
  final String kategorie;
  final String artnrlieferant;
  final String? lieferantandartikelnummer;
  final String artnrintern;
  final String eancode;
  final String? bezeichnung;
  final String material;
  final String dimension;
  final String haptik;
  final String optik;
  final String? sortierung;
  final String? vpeeinzeln;
  final String? einzelneinheit;
  final String? vpebund;
  final String? bundeinheit;
  final String? eigenschaft;
  final String? beanspruchungsklasse;
  final String? verfugbarkeit;
  final String? einkaufspreis;
  final String? verkaufspreiseins;
  final String? verkaufspreiszwei;
  final String? verkaufspreisdrei;
  final String? ausstellplatz;
  final String? imageName;
  late final String? imagePath;

  factory Artikel.fromJson(Map<String, dynamic> data) {
    final lieferant = data['lieferant'] as String;
    final artikeltyp = data['artikeltyp'] as String;
    final kategorie = data['kategorie'] as String;
    final artnrlieferant = data['artnrlieferant'] as String;
    final lieferantandartikelnummer =
        data['lieferantandartikelnummer'] as String?;
    //final artnrintern = int.parse(data['artnrintern'].toString());
    final artnrintern = data['artnrintern'].toString();
    //final eancode = int.parse(data['eancode']);
    final eancode = data['eancode'] as String;
    final bezeichnung = data['bezeichnung'] as String?;
    final material = data['material'] as String;
    final dimension = data['dimension'] as String;
    final haptik = data['haptik'] as String;
    final optik = data['optik'] as String;
    final sortierung = data['sortierung'] as String?;
    final vpeeinzeln = data['vpeeinzeln'] as String?;
    final einzelneinheit = data['einzelneinheit'] as String?;
    final vpebund = data['vpebund'] as String?;
    final bundeinheit = data['bundeinheit'] as String?;
    final eigenschaft = data['eigenschaft'] as String?;
    final beanspruchungsklasse = data['beanspruchungsklasse'] as String?;
    final verfugbarkeit = data['verfugbarkeit'] as String?;
    final einkaufspreis = data['einkaufspreis'] as String?;
    final verkaufspreiseins = data['verkaufspreiseins'] as String?;
    final verkaufspreiszwei = data['verkaufspreiszwei'] as String?;
    final verkaufspreisdrei = data['verkaufspreisdrei'] as String?;
    final ausstellplatz = data['ausstellplatz'] as String?;
    final imageName = data['image_name'] as String?;
    final imagePath = data['image_path'] as String?;
    return Artikel(
      lieferant: lieferant,
      artikeltyp: artikeltyp,
      kategorie: kategorie,
      artnrlieferant: artnrlieferant,
      lieferantandartikelnummer: lieferantandartikelnummer,
      artnrintern: artnrintern,
      eancode: eancode,
      bezeichnung: bezeichnung,
      material: material,
      dimension: dimension,
      haptik: haptik,
      optik: optik,
      sortierung: sortierung,
      vpeeinzeln: vpeeinzeln,
      einzelneinheit: einzelneinheit,
      vpebund: vpebund,
      bundeinheit: bundeinheit,
      eigenschaft: eigenschaft,
      beanspruchungsklasse: beanspruchungsklasse,
      verfugbarkeit: verfugbarkeit,
      einkaufspreis: einkaufspreis,
      verkaufspreiseins: verkaufspreiseins,
      verkaufspreiszwei: verkaufspreiszwei,
      verkaufspreisdrei: verkaufspreisdrei,
      ausstellplatz: ausstellplatz,
      imageName: imageName,
      imagePath: imagePath,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lieferant': lieferant,
      'artikeltyp': artikeltyp,
      'kategorie': kategorie,
      'artnrlieferant': artnrlieferant,
      if (lieferantandartikelnummer != null)
        'lieferantandartikelnummer': lieferantandartikelnummer,
      'artnrintern': artnrintern,
      'eancode': eancode.toString(),
      if (bezeichnung != null) 'bezeichnung': bezeichnung,
      'material': material,
      'dimension': dimension,
      'haptik': haptik,
      'optik': optik,
      if (sortierung != null) 'sortierung': sortierung,
      if (vpeeinzeln != null) 'vpeeinzeln': vpeeinzeln,
      if (einzelneinheit != null) 'einzelneinheit': einzelneinheit,
      if (vpebund != null) 'vpebund': vpebund,
      if (bundeinheit != null) 'bundeinheit': bundeinheit,
      if (eigenschaft != null) 'eigenschaft': eigenschaft,
      if (beanspruchungsklasse != null)
        'beanspruchungsklasse': beanspruchungsklasse,
      if (verfugbarkeit != null) 'verfugbarkeit': verfugbarkeit,
      if (einkaufspreis != null) 'einkaufspreis': einkaufspreis,
      if (verkaufspreiseins != null) 'verkaufspreiseins': verkaufspreiseins,
      if (verkaufspreiszwei != null) 'verkaufspreiszwei': verkaufspreiszwei,
      if (verkaufspreisdrei != null) 'verkaufspreisdrei': verkaufspreisdrei,
      if (ausstellplatz != null) 'ausstellplatz': ausstellplatz,
      if (imageName != null) 'imageName': imageName,
      if (imagePath != null) 'imagePath': imagePath,
    };
  }
}
