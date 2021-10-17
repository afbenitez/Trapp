import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:trapp_flutter/services/auth.dart';

final AuthService _auth = AuthService();


class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const NeumorphicApp(
      // debugShowCheckedModeBanner: false,
      title: 'Trapp',
      themeMode: ThemeMode.light,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: NeumorphicFloatingActionButton(
        child: const Icon(Icons.add, size: 30),
        onPressed: () {},
      ),
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            NeumorphicButton(
              onPressed: () {
                _auth.signOut();
              },
              style: const NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              padding: const EdgeInsets.all(12.0),
              child: const Icon(
                Icons.logout,
              ),
            ),
            const Text('LogOut'),
          ],
        ),
      ),
    );
  }
}