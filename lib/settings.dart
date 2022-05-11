import 'dart:developer';

import 'package:artenativ/settingsdevice.dart';
import 'package:flutter/material.dart';
import 'package:artenativ/settingsbelowside.dart';
import 'package:artenativ/services/shared_service.dart';

import 'globals.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String belowTitle = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Einstellungen'),
        backgroundColor: const Color(0xFFF76A25),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
                //SharedService.logout(context);
              },
              icon: const Icon(Icons.logout),
            ),
          )
        ],
      ),
      //drawer: const ChatDrawer(),
      body: SafeArea(
        child: Center(
            child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
              child: Column(
                children: [
                  settingsTile(
                      'Benutzerkonto',
                      Icons.account_box,
                      const SettingsBelowScreen(
                        title: 'Benutzerkonto',
                      )),
                  settingsTile(
                      'Privatsphäre',
                      Icons.security,
                      const SettingsBelowScreen(
                        title: 'Privatsphäre',
                      )),
                  settingsTile(
                      'Sicherheit',
                      Icons.lock,
                      const SettingsBelowScreen(
                        title: 'Sicherheit',
                      )),
                  settingsTile(
                      'Design',
                      Icons.color_lens,
                      const SettingsBelowScreen(
                        title: 'Design',
                      )),
                  settingsTile(
                      'Ton',
                      Icons.notifications_active,
                      const SettingsBelowScreen(
                        title: 'Ton',
                      )),
                  settingsTile(
                      'Geräte',
                      Icons.devices_other,
                      const SettingsDeviceScreen(
                        title: 'Geräte',
                      )),
                  settingsTile(
                      'Nachrichten',
                      Icons.chat,
                      const SettingsBelowScreen(
                        title: 'Nachrichten',
                      )),
                  settingsTile(
                      'Medien',
                      Icons.landscape,
                      const SettingsBelowScreen(
                        title: 'Medien',
                      )),
                  settingsTile(
                      'Fehlermeldung',
                      Icons.bug_report,
                      const SettingsBelowScreen(
                        title: 'Fehlermeldung',
                      )),
                  settingsTile(
                      'Über uns',
                      Icons.info_outline,
                      const SettingsBelowScreen(
                        title: 'Über uns',
                      )),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  settingsTile(String title, IconData icon, StatefulWidget side) {
    return SizedBox(
      width: 600,
      child: Card(
        //color: Theme.of(context).primaryColor,
        color: const Color(0xFFF76A25),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          child: ListTile(
            leading: Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
            title: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
            //subtitle: Text("Beautiful View !"),
            trailing: const Icon(
              Icons.navigate_next,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => side,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
