import 'package:flutter/material.dart';
import 'package:trapp_flutter/services/auth.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ required this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth  = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
        Scaffold(
          backgroundColor: Colors.transparent,
          body: _content(),
        )
    );
  }

  Widget _content(){
    return Container(
      padding: EdgeInsets.all(22),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 100,
              child: Text("Welcome!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_circle_rounded, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    )
                ),
                hintText: "Email",
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade50,
                ),
              ),
              validator: (val) => val!.isEmpty ? 'Enter an email' : null,
              onChanged: (val) {
                setState(() => email = val);
              },
            ),
            SizedBox(height: 15),
            TextFormField(
              obscureText: true,
              validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
              onChanged: (val) {
                setState(() => password = val);
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.view_compact_outlined, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    )
                ),
                hintText: "Password",
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: Color(0x808A8A82),
                ),
              ),
            ),
            SizedBox(height: 15),
            RaisedButton(
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'Could not sign in with those credentials';
                      });
                    }else{
                      Navigator.pop(context);
                    }
                  }
                },
                color: Color(0xff00AFB9),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))) ,
                child: Center(child: Text('Sign In', style: TextStyle( color: Color(0xffF3F9E3)),),),),
            SizedBox(height: 12.0),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}