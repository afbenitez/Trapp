import 'package:flutter/material.dart';
import 'package:trapp_flutter/services/auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgSignIn.jpeg'),
            fit: BoxFit.cover,
          ),
      ),
      child:
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: _content(),
          ),
        )
    );
  }

  Widget _content(){
    return Container(
      padding: EdgeInsets.all(22),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
              child: Text(
                'TRAPP',
                style: TextStyle(
                  fontFamily: 'trapp',
                  fontSize:MediaQuery.of(context).size.width/4,
                ),
              ),
            ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(34),
                decoration: BoxDecoration(
                    color: Color(0xffF3F3F3),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 3,
                        blurRadius: 10,
                      )
                    ]
                ),
                child: Column(
                  children: [
                    Positioned(child: Text("Welcome!",
                      style: TextStyle(
                        fontFamily: 'thaBold',
                        fontSize: MediaQuery.of(context).size.width/7,
                        color: Color(0xff7B767D),
                      ),),
                      top: 550,),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
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
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade50,
                        ),
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      obscureText: true,
                      validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            )
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),

                      child: Center(child: Text('Sign In', style: TextStyle( color: Color(0xffF3F9E3)),),),
                    ),
                    SizedBox(height: 12.0),
                      Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}