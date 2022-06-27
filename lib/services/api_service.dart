import 'dart:convert';
import 'dart:developer';

import 'package:artenativ/models/artikel_request.dart';
import 'package:artenativ/models/artikel_response.dart';
import 'package:artenativ/models/addartikel_request_model.dart';
import 'package:artenativ/models/addartikel_response_model.dart';
import 'package:artenativ/models/login_request_model.dart';
import 'package:artenativ/models/login_response_model.dart';
import 'package:artenativ/models/register_request_model.dart';
import 'package:artenativ/models/register_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:artenativ/globals.dart';
import '../../config.dart';
import 'shared_service.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(
    LoginRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    //http Login
    var url = Uri.http(
      Config.apiURL,
      Config.loginAPI,
    );

    //https Login
    /*var url = Uri.https(
      Config.apiURL,
      Config.loginAPI,
    );*/

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      //await SharedService.setLoginDetails(
      loginResponseJson(
        response.body,
        //),
      );
      //);

      return true;
    } else {
      return false;
    }
  }

  static Future<Object> getlastinternid() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };

    //http Get Last Intern ID Number
    var url = Uri.http(
      Config.apiURL,
      Config.internartikelidAPI,
    );

    //https Get Last Intern ID Number
    /*var url = Uri.https(
      Config.apiURL,
      Config.internartikelidAPI,
    );*/

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      /**var testbody = response.body;
      log('ResponseBody: $testbody');*/
      final products = json.decode(response.body);
      int lastInternArtId;
      artNrIntern = products[0]['artnrintern'];
      if (artNrIntern != null) {
        artNrInternPlus = artNrIntern! + 1;
        log("Global Intern ID Plus API: $artNrInternPlus");
      }

      lastInternArtId = products[0]['artnrintern'];
      /**log('TestBody: $testbody');
      log('InternID: $lastInternArtId');
      lastInternArtId++;
      log('InternID: $lastInternArtId');*/
      log('Global Intern ID API: $artNrIntern');
      return lastInternArtId;
    } else {
      return false;
    }
  }

  static Future<Object> findartikel(int artnrintern) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };

    String urlArtNrIntern = artnrintern.toString();

    //http Find One Artikel
    var url = Uri.http(
      Config.apiURL,
      //Config.findartikelAPI + '10000045',
      Config.findartikelAPI + urlArtNrIntern,
    );

    //https Find One Artikel
    /*var url = Uri.https(
      Config.apiURL,
      Config.findartikelAPI + urlArtNrIntern,
    );*/

    log('URL: $url');

    var response = await client.get(url, headers: requestHeaders);

    /*var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );*/

    List<Artikel> parseArtikel(String responseBody) {
      final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

      final testtt =
          parsed.map<Artikel>((json) => Artikel.fromJson(json)).toList();

      log("PARSED: {$testtt}");
      return parsed.map<Artikel>((json) => Artikel.fromJson(json)).toList();
    }

    if (response.statusCode == 200) {
      final parsedJSON = jsonDecode(response.body);
      final parsedJSON2 = json.decode(response.body);

      log('PARS: {$parsedJSON}');
      log('PARS2: {$parsedJSON2}');
      print('${parsedJSON.runtimeType} : $parsedJSON');

      final findartikel = Artikel.fromJson(parsedJSON);
      log('FindArtikel: $findartikel');
      var lokallieferant = findartikel.lieferant;

      findLieferant = findartikel.lieferant;
      findArtikeltyp = findartikel.artikeltyp;
      findKategorie = findartikel.kategorie;
      findArtNrLieferant = findartikel.artnrlieferant.toString();
      findLieferantandartikelnummer =
          findartikel.lieferantandartikelnummer.toString();
      findArtNrIntern = findartikel.artnrintern.toString();
      findEanCode = findartikel.eancode.toString();
      findBezeichnung = findartikel.bezeichnung;
      findMaterial = findartikel.material;
      findDimension = findartikel.dimension;
      findHaptik = findartikel.haptik;
      findOptik = findartikel.optik;
      findSortierung = findartikel.sortierung;
      findVpeEinzeln = findartikel.vpeeinzeln;
      findEinzelnVerpackungseinheiten = findartikel.einzelneinheit;
      findVpeBund = findartikel.vpebund;
      findBundVerpackungseinheiten = findartikel.bundeinheit;
      findEigenschaft = findartikel.eigenschaft;
      findBeanspruchungsklasse = findartikel.beanspruchungsklasse;
      findVerfugbarkeit = findartikel.verfugbarkeit;
      findEinkaufspreis = findartikel.einkaufspreis;
      findVerkaufspreisEins = findartikel.verkaufspreiseins;
      findVerkaufspreisZwei = findartikel.verkaufspreiszwei;
      findVerkaufspreisDrei = findartikel.verkaufspreisdrei;
      //findVerkaufspreisMWST = findartikel.verkaufspreismwst;
      findAusstellplatz = findartikel.ausstellplatz;
      findImageName = findartikel.imageName;
      findImagePath = findartikel.imagePath;

      log('findLieferant: $lokallieferant');
      log('findArtikeltyp: $findArtikeltyp');
      log('findKategorie: $findKategorie');
      log('findArtNrLieferant: $findArtNrLieferant');
      log('findArtNrIntern: $findArtNrIntern');
      log('findEanCode: $findEanCode');
      log('findBezeichnung: $findBezeichnung');
      log('findMaterial: $findMaterial');
      log('findDimension: $findDimension');
      log('findHaptik: $findHaptik');
      log('findOptik: $findOptik');
      log('findSortierung: $findSortierung');
      log('findVpeEinzeln: $findVpeEinzeln');
      log('findVpeBund: $findVpeBund');
      log('findEigenschaft: $findEigenschaft');
      log('findBeanspruchungsklasse: $findBeanspruchungsklasse');
      log('findVerfugbarkeit: $findVerfugbarkeit');
      log('findEinkaufspreis: $findEinkaufspreis');
      log('findVerkaufspreisEins: $findVerkaufspreisEins');
      log('findVerkaufspreisZwei: $findVerkaufspreisZwei');
      log('findVerkaufspreisDrei: $findVerkaufspreisDrei');
      //log('findVerkaufspreisMWST: ${findVerkaufspreisMWST}');
      log('findAusstellplatz: $findAusstellplatz');
      log('findImageName: $findImageName');
      log('findImagePath: $findImagePath');

      return findartikel;
      //return parseArtikel(response.body);
    } else {
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
    RegisterRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    //http User Registration
    var url = Uri.http(
      Config.apiURL,
      Config.registerAPI,
    );

    //https User Registration
    /*var url = Uri.https(
      Config.apiURL,
      Config.registerAPI,
    );*/

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseJson(
      response.body,
    );
  }

  static Future<AddartikelResponseModel> addartikel(
    AddartikelRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    //http Add Article
    var url = Uri.http(
      Config.apiURL,
      Config.addartikelAPI,
    );

    //https Add Article
    /*var url = Uri.https(
      Config.apiURL,
      Config.addartikelAPI,
    );*/

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return addArtikelResponseJson(
      response.body,
    );
  }

  static Future<ArtikelResponse> updateartikel(
      Artikel model, String findArtNrIntern) async {
    Map<String, String> requestHeaders = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
    };

    log("ArtNrInternAPI: " + findArtNrIntern);

    //http Update Article
    var url = Uri.http(
      Config.apiURL,
      Config.updateartikelAPI + findArtNrIntern,
    );

    //https Update Article
    /*var url = Uri.https(
      Config.apiURL,
      Config.updateartikelAPI + findArtNrIntern,
    );*/

    log('URL: ' + url.toString());
    log('JSON Encode: ' + jsonEncode(model.toJson()));

    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
      /**body: jsonEncode(<String, String>{
              "lieferant": model.lieferant,
              "artikeltyp": model.artikeltyp,
              "kategorie": model.kategorie,
              "artnrlieferant": model.artnrlieferant,
              "lieferantandartikelnummer": model.lieferantandartikelnummer!,
              "artnrintern": model.artnrintern,
              "eancode": model.eancode,
              "bezeichnung": model.bezeichnung!,
              "material": model.material,
              "dimension": model.dimension,
              "haptik": model.haptik,
              "optik": model.optik,
              "sortierung": model.sortierung!,
              "vpeeinzeln": model.vpeeinzeln!,
              "einzelneinheit": model.einzelneinheit!,
              "vpebund": model.vpebund!,
              "bundeinheit": model.bundeinheit!,
              "eigenschaft": model.eigenschaft!,
              "beanspruchungsklasse": model.beanspruchungsklasse!,
              "verfugbarkeit": model.verfugbarkeit!,
              "einkaufspreis": model.einkaufspreis!,
              "verkaufspreiseins": model.verkaufspreiseins!,
              "verkaufspreiszwei": model.verkaufspreiszwei!,
              "verkaufspreisdrei": model.verkaufspreisdrei!,
              "ausstellplatz": model.ausstellplatz!
            })*/
    );
    /*)
        .then((result) {
      print('Status-Code: ' + result.statusCode.toString());
      print('Body: ' + result.body);
    });*/

    //debugPrint(response.body);
    //log(response.body);

    return ArtikelResponse.fromJson(json.decode(response.body));
    //return artikelResponseJson(response.body);
  }

  static Future<String> getUserProfile() async {
    //var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
      //'Authorization': 'Basic ${loginDetails!.data.token}'
    };

    var url = Uri.http(Config.apiURL, Config.userProfileAPI);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }
}
