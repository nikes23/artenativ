import 'package:artenativ/home.dart';
import 'package:artenativ/login.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
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
                                  'Passwort zurücksetzen',
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
                                        'E-Mail*',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    //validator: UserNameValidator.validate,
                                    style: const TextStyle(
                                        fontSize: 18.0, color: Colors.black),
                                    decoration: buildSignUpInputDecoration(
                                        'E-Mail eingeben', Icons.mail),
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
                              width: 600,
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 20.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '* Pflichtfeld',
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
                                        'Zurück zu',
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
                                                fontWeight: FontWeight.w700),
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

  InputDecoration buildSignUpInputDecoration(String hint, IconData icon) {
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
    );
  }

  Widget buildSignUpInputDecorationPassword(String hint, IconData icon) {
    return TextFormField(
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }

  Widget buildSignUpInputDecorationConfirmPassword(String hint, IconData icon) {
    return TextFormField(
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
        suffixIcon: hint == 'Passwort bestätigen'
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
      obscureText: hint == 'Passwort bestätigen' ? _isHidden : false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }

  InputDecoration buildSignUpInputDecorationImage(
      String hint, AssetImage icon) {
    return InputDecoration(
      prefixIcon: Transform.scale(
        scale: 0.5,
        child: ImageIcon(
          icon,
          color: Colors.black,
        ),
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
            'Bestätigen',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23.0,
            ),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgetPasswordScreen(),
                      fullscreenDialog: true));
            }
          }),
    );
  }

  void navigateToSignIn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginScreen(), fullscreenDialog: true));
  }
}
