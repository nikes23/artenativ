import 'dart:convert';

RegisterResponseModel registerResponseJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel {
  RegisterResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final String? data;
  //late final Data? data;

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
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
    required this.firstname,
    required this.lastname,
    //required this.username,
    required this.email,
    required this.date,
    required this.id,
  });
  late final String? firstname;
  late final String? lastname;
  //late final String? username;
  late final String? email;
  late final String? date;
  late final String? id;

  Data.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    //username = json['username'];
    email = json['email'];
    date = json['date'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    //_data['username'] = username;
    _data['email'] = email;
    _data['date'] = date;
    _data['id'] = id;
    return _data;
  }
}
