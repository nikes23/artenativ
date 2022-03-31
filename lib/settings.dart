import 'package:artenativ/login.dart';
import 'package:flutter/material.dart';
import 'package:artenativ/additemsextend.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                        fullscreenDialog: true));
              },
              icon: const Icon(Icons.logout),
            ),
          )
        ],
      ),
      //drawer: const ChatDrawer(),
      body: getListView(context),
    );
  }
}

Widget getListView(BuildContext context) {
  return SafeArea(
    child: Center(
        child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
          child: Column(
            children: [
              SizedBox(
                width: 600,
                child: Card(
                  //color: Theme.of(context).primaryColor,
                  color: const Color(0xFFF76A25),
                  elevation: 10,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.account_box,
                        size: 30,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Account',
                        style: TextStyle(color: Colors.white),
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
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 600,
                child: Card(
                  color: const Color(0xFFF76A25),
                  elevation: 10,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.security,
                        color: Colors.white,
                        size: 30,
                      ),
                      title: const Text(
                        'Privacy',
                        style: TextStyle(color: Colors.white),
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
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 600,
                child: Card(
                  color: const Color(0xFFF76A25),
                  elevation: 10,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 30,
                      ),
                      title: const Text(
                        'Security',
                        style: TextStyle(color: Colors.white),
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
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 600,
                child: Card(
                  color: const Color(0xFFF76A25),
                  elevation: 10,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.color_lens,
                        color: Colors.white,
                        size: 30,
                      ),
                      title: const Text(
                        'Design',
                        style: TextStyle(color: Colors.white),
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
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 600,
                child: Card(
                  color: const Color(0xFFF76A25),
                  elevation: 10,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.notifications_active,
                        color: Colors.white,
                        size: 30,
                      ),
                      title: const Text(
                        'Sound',
                        style: TextStyle(color: Colors.white),
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
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 600,
                child: Card(
                  color: const Color(0xFFF76A25),
                  elevation: 10,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.chat,
                        color: Colors.white,
                        size: 30,
                      ),
                      title: const Text(
                        'Chat',
                        style: TextStyle(color: Colors.white),
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
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 600,
                child: Card(
                  color: const Color(0xFFF76A25),
                  elevation: 10,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.landscape,
                        color: Colors.white,
                        size: 30,
                      ),
                      title: const Text(
                        'Media',
                        style: TextStyle(color: Colors.white),
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
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 600,
                child: Card(
                  color: const Color(0xFFF76A25),
                  elevation: 10,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.bug_report,
                        color: Colors.white,
                        size: 30,
                      ),
                      title: const Text(
                        'Bugfix',
                        style: TextStyle(color: Colors.white),
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
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 600,
                child: Card(
                  color: const Color(0xFFF76A25),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, right: 8.0, left: 10.0, bottom: 0.0),
                    child: ListTile(
                      leading: const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: 25,
                      ),
                      title: const Text(
                        'Über uns',
                        style: TextStyle(color: Colors.white),
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
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    )),
  );
}
