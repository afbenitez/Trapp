import 'package:flutter/material.dart';
import 'package:trapp_flutter/services/auth.dart';

final AuthService _auth = AuthService();

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[50],
      appBar: AppBar(
        title: const Text('Home Trapp'),
        backgroundColor: Colors.lightBlueAccent[300],
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
