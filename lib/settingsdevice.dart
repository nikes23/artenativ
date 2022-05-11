import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:artenativ/globals.dart';
import 'package:flutter/services.dart';

class SettingsDeviceScreen extends StatefulWidget {
  final String title;
  const SettingsDeviceScreen({Key? key, required this.title}) : super(key: key);

  @override
  _SettingsDeviceScreenState createState() =>
      _SettingsDeviceScreenState(title: title);
}

class _SettingsDeviceScreenState extends State<SettingsDeviceScreen> {
  final String title;
  _SettingsDeviceScreenState({required this.title});

  final _formKey = GlobalKey<FormState>();

  TextEditingController printerIpController = TextEditingController();
  TextEditingController printerPortController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    printerIpController.dispose();
    printerPortController.dispose();
    _formKey.currentState?.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(title),
        backgroundColor: const Color(0xFFF76A25),
      ),
      //drawer: const ChatDrawer(),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                      top: 20.0, right: 20.0, left: 20.0, bottom: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Drucker',
                          style: TextStyle(
                            color: Color(0xFFF76A25),
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //Printer IP-Address
                        SizedBox(
                          width: 600,
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'IP-Adresse*',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: printerIpController
                                  ..text = printerIp,
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                decoration: buildInputDecorationIcon(
                                    'IP-Adresse eingeben', Icons.location_on),
                                onSaved: (value) => printerIp = value!,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bitte geben Sie eine IP-Adresse ein';
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
                        //Printer Port
                        SizedBox(
                          width: 600,
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Port*',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: printerPortController
                                  ..text = printerPort.toString(),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                  LengthLimitingTextInputFormatter(5),
                                ],
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                decoration: buildInputDecorationIcon(
                                    'Port eingeben', Icons.lan),
                                onSaved: (value) =>
                                    printerPort = int.parse(value!),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bitte geben Sie einen Port ein';
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
                        const SizedBox(
                          width: 600,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 20.0),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
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

  InputDecoration buildInputDecorationIcon(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
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
            'Speichern',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23.0,
            ),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              log('OldPrinterIP: $printerIp');
              log('OldPrinterPort: $printerPort');

              String? testPrinterIp = printerIpController.text;
              int testprinterPort = int.parse(printerPortController.text);

              log('___PrinterIPCon: $testPrinterIp');
              log('___PrinterPortCon: $testprinterPort');

              setState(() {
                printerIp = printerIpController.text;
                printerPort = int.parse(printerPortController.text);

                log('NewPrinterIP: $printerIp');
                log('NewPrinterPort: $printerPort');
              });

              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Center(
                            child: Text(
                          'Hurra!',
                          style: TextStyle(color: Color(0xFFF76A25)),
                        )),
                        content: const Text(
                            'Die IP-Adresse und der Port wurden erfolgreich geändert'),
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
          }),
    );
  }
}
