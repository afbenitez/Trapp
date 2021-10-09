import 'package:flutter/material.dart';
import 'package:trapp_flutter/services/auth.dart';
class SignUp extends StatefulWidget {

  final Function toggleView;
  SignUp({ required this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<SignUp> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String name = '';


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgSignUp.jpeg'),
            fit: BoxFit.cover,
          )
      ),
      child:
        Scaffold(
          backgroundColor: Colors.transparent,
          body: _content(),
        ),

    );

  }

  Widget _content(){
    return
    Container(
      padding: EdgeInsets.all(22),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 100.0,
              child: Text("Join Us!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
            SizedBox(
              height: 20,
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
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              textCapitalization: TextCapitalization.words,
              textAlign: TextAlign.center,
              validator: (val) => val!.isEmpty ? 'Enter an email' : null,
              onChanged: (val) {
                setState(() => email = val);
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              obscureText: true,
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
              keyboardType: TextInputType.name,
              maxLines: 1,
              textCapitalization: TextCapitalization.words,
              textAlign: TextAlign.center,
              validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
              onChanged: (val) {
                setState(() => password = val);
              },
            ),
            SizedBox(
              height: 25,
            ),
            RaisedButton(onPressed: ()async {
              if (_formKey.currentState!.validate()) {
                setState(() => loading = true);
                dynamic result = await _auth.registerWithEmailAndPassword(
                    email, password, name);
                if (result == null) {
                  setState(() {
                    loading = false;
                    error = 'Please supply a valid email';
                  });
                }
              }
            }, color: Color(0xff00AFB9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))) ,child: Center(child: Text('Sign In', style: TextStyle( color: Color(0xffF3F9E3)),)))
          ]

        )

      ),
    );

  }
}