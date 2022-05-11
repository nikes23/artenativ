import 'package:artenativ/config.dart';
import 'package:artenativ/models/register_request_model.dart';
import 'package:artenativ/services/api_service.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:artenativ/home.dart';
import 'package:artenativ/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _userStatusController = TextEditingController();
  String? _username = '';
  String? _firstName = '';
  String? _lastName = '';
  String? _phoneNumber = '';
  String? _email = '';
  String? _password = '';
  String? _confirmPassword = '';
  String? _userStatus = '';
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFFF76A25)),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        //backgroundColor: const Color(0xFF2F2F2F),
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                          top: 60.0, right: 20.0, left: 20.0, bottom: 20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 600,
                              child: Center(
                                child: Image(
                                  image: AssetImage(
                                      'assets/Artenativ_Logo_Schwarz.png'),
                                  height: 220,
                                  width: 220,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            const SizedBox(
                              width: 600,
                              child: Center(
                                child: Text(
                                  'Registrieren',
                                  style: TextStyle(
                                      color: Color(0xFFF76A25),
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              width: 600,
                              child: Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Vorname*',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _firstNameController,
                                    onChanged: (firstnamefield) {
                                      _firstName = _firstNameController.text;
                                    },
                                    //validator: UserNameValidator.validate,
                                    style: const TextStyle(
                                        fontSize: 18.0, color: Colors.black),
                                    decoration: buildSignUpInputDecoration(
                                        'Vorname eingeben',
                                        Icons.person,
                                        _firstNameController),
                                    onSaved: (value) => _firstName = value!,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Bitte geben Sie Ihren Vornamen ein';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            SizedBox(
                              width: 600,
                              child: Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Nachname*',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _lastNameController,
                                    onChanged: (lastnamefield) {
                                      _lastName = _lastNameController.text;
                                    },
                                    //validator: UserNameValidator.validate,
                                    style: const TextStyle(
                                        fontSize: 18.0, color: Colors.black),
                                    decoration: buildSignUpInputDecoration(
                                        'Nachnamen eingeben',
                                        Icons.person,
                                        _lastNameController),
                                    onSaved: (value) => _lastName = value!,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Bitte geben Sie Ihren Nachnamen ein';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            SizedBox(
                              width: 600,
                              child: Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'E-Mail*',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _mailController,
                                    onChanged: (emailfield) {
                                      _email = _mailController.text;
                                    },
                                    //validator: UserNameValidator.validate,
                                    style: const TextStyle(
                                        fontSize: 18.0, color: Colors.black),
                                    decoration: buildSignUpInputDecoration(
                                        'E-Mail eingeben',
                                        Icons.mail,
                                        _mailController),
                                    onSaved: (value) => _email = value!,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Bitte geben Sie Ihre E-Mail ein';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            SizedBox(
                              width: 600,
                              child: Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Passwort*',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  buildSignUpInputDecorationPassword(
                                      'Passwort', Icons.lock),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            SizedBox(
                              width: 600,
                              child: Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Passwort bestätigen*',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  buildSignUpInputDecorationConfirmPassword(
                                      'Passwort bestätigen', Icons.lock),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 600,
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 20.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '* Pflichtfelder',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            buildButtonContainer(),
                            const SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              width: 600,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Haben Sie bereits ein Konto?',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle:
                                                const TextStyle(fontSize: 20),
                                            primary: Colors.transparent,
                                          ),
                                          child: const Text(
                                            'Anmelden',
                                            style: TextStyle(
                                                color: Color(0xFFF76A25),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () {
                                            navigateToSignIn();
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration buildSignUpInputDecoration(
      String hint, IconData icon, TextEditingController controller) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.black,
        fontSize: 18.0,
      ),
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.black,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(width: 2, color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(width: 2, color: Color(0xFFF76A25)),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      prefixIcon: Icon(
        icon,
        color: Colors.black,
      ),
      suffixIcon: IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          controller.clear();
        },
        color: Colors.black,
        splashColor: const Color(0xFFF76A25),
      ),
    );
  }

  Widget buildSignUpInputDecorationPassword(String hint, IconData icon) {
    return TextFormField(
      controller: _passwordController,
      onChanged: (passwordfield) {
        _password = _passwordController.text;
      },
      style: const TextStyle(color: Colors.black, fontSize: 18.0),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.black,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(width: 2, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(width: 2, color: Color(0xFFF76A25)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
        suffixIcon: hint == 'Passwort'
            ? IconButton(
                splashColor: const Color(0xFFF76A25),
                onPressed: _toggleVisibility,
                icon: _isHidden
                    ? const Icon(
                        Icons.visibility_off,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.visibility,
                        color: Colors.black,
                      ),
              )
            : null,
      ),
      obscureText: hint == 'Passwort' ? _isHidden : false,
      onSaved: (value) => _password = value!,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Bitte geben Sie ein Passwort ein';
        }
        return null;
      },
    );
  }

  Widget buildSignUpInputDecorationConfirmPassword(String hint, IconData icon) {
    return TextFormField(
      controller: _confirmPasswordController,
      onChanged: (confirmpasswordfield) {
        _confirmPassword = _confirmPasswordController.text;
      },
      style: const TextStyle(color: Colors.black, fontSize: 18.0),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(width: 2, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(width: 2, color: Color(0xFFF76A25)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
        suffixIcon: hint == 'Passwort bestätigen'
            ? IconButton(
                splashColor: const Color(0xFFF76A25),
                onPressed: _toggleVisibility,
                icon: _isHidden
                    ? const Icon(
                        Icons.visibility_off,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.visibility,
                        color: Colors.black,
                      ),
              )
            : null,
      ),
      obscureText: hint == 'Passwort bestätigen' ? _isHidden : false,
      onSaved: (value) => _confirmPassword = value!,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Bitte geben Sie Ihr Passwort ein';
        }
        return null;
      },
    );
  }

  InputDecoration buildSignUpInputDecorationImage(
      String hint, AssetImage icon, TextEditingController controller) {
    return InputDecoration(
      prefixIcon: Transform.scale(
        scale: 0.5,
        child: ImageIcon(
          icon,
          color: Colors.black,
        ),
      ),
      suffixIcon: IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          controller.clear();
        },
        color: Colors.black,
        splashColor: const Color(0xFFF76A25),
      ),
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.black,
        fontSize: 18.0,
      ),
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.black,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(width: 2, color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(width: 2, color: Color(0xFFF76A25)),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  Widget buildButtonContainer() {
    return Container(
      height: 56.0,
      //width: MediaQuery.of(context).size.width,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFFF76A25),
      ),
      child: MaterialButton(
          child: const Text(
            'Registrierung',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23.0,
            ),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              setState(() {
                _username = _userNameController.text;
                _firstName = _firstNameController.text;
                _lastName = _lastNameController.text;
                _phoneNumber = _phoneNumberController.text;
                _email = _mailController.text;
                _password = _passwordController.text;
                _confirmPassword = _confirmPasswordController.text;
                _userStatus = _userStatusController.text;
              });

              if (_password == _confirmPassword) {
                RegisterRequestModel model = RegisterRequestModel(
                  firstname: _firstName,
                  lastname: _lastName,
                  password: _password,
                  email: _email,
                );

                APIService.register(model).then(
                  (response) {
                    setState(() {
                      //isApiCallProcess = false;
                    });

                    if (response.data != null) {
                      /*showSimpleAlertDialog(
                        context,
                        Config.appName,
                        "Die Registrierung war erfolgreich!",
                        "OK",
                        () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
                            (route) => false,
                          );
                        },
                      );*/
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Center(
                                    child: Text(
                                  'Hurra!',
                                  style: TextStyle(color: Color(0xFFF76A25)),
                                )),
                                content: const Text(
                                    'Die Registrierung war erfolgreich!'),
                                actions: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Container(
                                        height: 36.0,
                                        width: 80.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: const Color(0xFFF76A25),
                                        ),
                                        child: MaterialButton(
                                            child: const Text(
                                              "OK",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/home',
                                                (route) => false,
                                              );
                                              _userNameController.clear();
                                              _firstNameController.clear();
                                              _lastNameController.clear();
                                              _phoneNumberController.clear();
                                              _mailController.clear();
                                              _passwordController.clear();
                                              _confirmPasswordController
                                                  .clear();
                                              _userStatusController.clear();
                                              log('Username: $_username');
                                              log('Vorname: $_firstName');
                                              log('Nachname: $_lastName');
                                              log('Telefonnummer: $_phoneNumber');
                                              log('Mail: $_email');
                                              log('Passwort1: $_password');
                                              log('Passwort2: $_confirmPassword');
                                              log('Benutzerstatus: $_userStatus');
                                            }),
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage(),
                              fullscreenDialog: true));*/
                    } else {
                      /**
                      showSimpleAlertDialog(
                        context,
                        Config.appName,
                        response.message,
                        "OK",
                        () {
                          Navigator.of(context).pop();
                        },
                      );
                      */
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Center(
                                    child: Text(
                                  'Oops, ein Fehler ist aufgetreten!',
                                  style: TextStyle(color: Color(0xFFF76A25)),
                                )),
                                content: Text(response.message),
                                actions: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Container(
                                        height: 36.0,
                                        width: 80.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: const Color(0xFFF76A25),
                                        ),
                                        child: MaterialButton(
                                            child: const Text(
                                              "OK",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }),
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                    }
                  },
                );
              } else if (_password != _confirmPassword) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Center(
                              child: Text(
                            'Oops, ein Fehler ist aufgetreten!',
                            style: TextStyle(color: Color(0xFFF76A25)),
                          )),
                          content:
                              const Text('Passwörter stimmen nicht überein'),
                          actions: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Container(
                                  height: 36.0,
                                  width: 80.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: const Color(0xFFF76A25),
                                  ),
                                  child: MaterialButton(
                                      child: const Text(
                                        "OK",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                ),
                              ),
                            ),
                          ],
                        ));
              }
            }
          }),
    );
  }

  static void showSimpleAlertDialog(
    BuildContext context,
    String title,
    String message,
    String buttonText,
    Function onPressed,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: [
            // submitButton(
            //   buttonText,
            //   onPressed(),
            // ),
            new TextButton(
              onPressed: () {
                return onPressed();
              },
              child: new Text(buttonText),
            )
          ],
        );
      },
    );
  }

  void navigateToSignIn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginScreen(), fullscreenDialog: true));
  }
}
