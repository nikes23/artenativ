import 'dart:convert';
import 'dart:developer';
import 'package:artenativ/models/artikel_request.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:http/http.dart' as http;
import 'package:artenativ/models/ItemDataModel.dart';

import '../config.dart';

Future<List<ItemDataModel>> ReadJsonData() async {
  final jsondata =
      await rootBundle.rootBundle.loadString('jsonfile/productlist.json');
  final list = json.decode(jsondata) as List<dynamic>;

  return list.map((e) => ItemDataModel.fromJson(e)).toList();
}

Future<List<Artikel>> LiveJsonData() async {
  //http Search for all Articles
  var url = Uri.http(
    Config.apiURL,
    Config.getAllArticleAPI,
  );

  //https Search for all Articles
  /*var url = Uri.https(
    Config.apiURL,
    Config.getAllArticleAPI,
  );*/

  log("URL: " + url.toString());

  final http.Response response = await http.get(Uri.parse(url.toString()));

  if (response.statusCode == 200) {
    return compute(parseArticle, response.body);
  } else {
    throw Exception(response.statusCode);
  }
}

List<Artikel> parseArticle(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var users = list.map((e) => Artikel.fromJson(e)).toList();
  return users;
}

final String url = "https://epiploic-jewel.000webhostapp.com/out.php?search=";

List<ItemDataModel> parseUser(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var users = list.map((e) => ItemDataModel.fromJson(e)).toList();
  return users;
}

Future<List<ItemDataModel>> fetchUsers() async {
  final http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return compute(parseUser, response.body);
  } else {
    throw Exception(response.statusCode);
  }
}
