import 'package:flutter/material.dart';
import 'package:trapp_flutter/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth  = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent[400],
        elevation: 0.0,
        title: Text('sign in to trapp'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
          child: Text('Sign in'),
          onPressed: () async {
            print('trying to sign in');
            dynamic result = await _auth.signInAnon();
            if(result == null){
              print('error on sign in');
            }else{
              print('signed in');
              print(result.uid);
            }
          },
        ),
      ),
    );
  }
}
