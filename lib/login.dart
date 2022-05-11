import 'dart:developer';

import 'package:artenativ/forgetpassword.dart';
import 'package:artenativ/home.dart';
import 'package:artenativ/models/login_request_model.dart';
import 'package:artenativ/services/api_service.dart';
import 'package:artenativ/sign_up.dart';
import 'package:flutter/material.dart';

import 'config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isApiCallProcess = false;
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String errorMessage = '';
  String successMessage = '';
  String? email;
  String? password;
  final myControllerMail = TextEditingController();
  final myControllerPassword = TextEditingController();
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerMail.dispose();
    super.dispose();
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
                          children: <Widget>[
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
                                  'Anmelden',
                                  style: TextStyle(
                                    color: Color(0xFFF76A25),
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                        'E-Mail',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  buildTextFieldMail('E-Mail'),
                                ],
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
                                        'Passwort',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  buildTextFieldPassword('Passwort'),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            SizedBox(
                              width: 600,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage(),
                                            fullscreenDialog: true));
                                  },
                                  child: Center(
                                    child: SizedBox(
                                      width: 700,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ForgetPasswordScreen(),
                                                      fullscreenDialog: true));
                                            },
                                            child: const Text(
                                              'Passwort vergessen',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
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
                                        'Sie haben noch kein Konto?',
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
                                            'Registrieren',
                                            style: TextStyle(
                                                color: Color(0xFFF76A25),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          onPressed: () {
                                            navigateToSignUp();
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
                      /*inAsyncCall: isApiCallProcess,
                        opacity: 0.3,
                        key: UniqueKey(),*/
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

  Widget buildTextFieldMail(String hintText) {
    return SizedBox(
      width: 700,
      child: TextFormField(
        controller: myControllerMail,
        onChanged: (emailfield) {
          email = myControllerMail.text;
        },
        style: const TextStyle(color: Colors.black, fontSize: 18.0),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
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
          prefixIcon: hintText == 'E-Mail'
              ? const Icon(
                  Icons.email,
                  color: Colors.black,
                )
              : const Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
          suffixIcon: hintText == 'Passwort'
              ? IconButton(
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
        obscureText: hintText == 'Passwort' ? _isHidden : false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Bitte geben Sie Ihre E-Mail ein';
          }
          return null;
        },
        onSaved: (value) => email = value!,
      ),
    );
  }

  Widget buildTextFieldPassword(String hintText) {
    return SizedBox(
      width: 700,
      child: TextFormField(
        controller: myControllerPassword,
        onChanged: (passwordfield) {
          password = myControllerPassword.text;
        },
        style: const TextStyle(color: Colors.black, fontSize: 18.0),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
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
          prefixIcon: hintText == 'E-Mail'
              ? const Icon(
                  Icons.email,
                  color: Colors.black,
                )
              : const Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
          suffixIcon: hintText == 'Passwort'
              ? IconButton(
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
        obscureText: hintText == 'Passwort' ? _isHidden : false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Bitte geben Sie Ihr Passwort ein';
          }
          return null;
        },
        onSaved: (value) => password = value!,
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
            'Anmelden',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23.0,
            ),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              setState(() {
                isApiCallProcess = true;
              });

              LoginRequestModel model = LoginRequestModel(
                email: email,
                password: password,
              );

              APIService.login(model).then(
                (response) {
                  setState(() {
                    isApiCallProcess = false;
                  });

                  if (response) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
                    APIService.getlastinternid();
                  } else {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Center(
                                  child: Text(
                                Config.appName,
                                style: TextStyle(color: Color(0xFFF76A25)),
                              )),
                              content: const Text(
                                  "Der Benutzername oder das Passwort ist ungültig!"),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: GestureDetector(
                                        child: const Text("OK"),
                                        onTap: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ),
                              ],
                            ));
                  }
                },
              );

              /*
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomePage(),
                      fullscreenDialog: true));
              */

            }
          }),
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void navigateToSignIn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HomePage(), fullscreenDialog: true));
  }

  void navigateToSignUp() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SignUpScreen(),
            fullscreenDialog: true));
  }
}

/*
class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;

  ProgressHUD({
    required Key key,
    required this.child,
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = new List<Widget>.empty(growable: true);
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = new Stack(
        children: [
          new Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          new Center(child: new CircularProgressIndicator()),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}

*/
