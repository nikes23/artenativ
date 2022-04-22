class RegisterRequestModel {
  RegisterRequestModel({
    this.firstname,
    this.lastname,
    //this.username,
    this.password,
    this.email,
  });
  late final String? firstname;
  late final String? lastname;
  //late final String? username;
  late final String? password;
  late final String? email;

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    //username = json['username'];
    password = json['password'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    //_data['username'] = username;
    _data['password'] = password;
    _data['email'] = email;
    return _data;
  }
}
