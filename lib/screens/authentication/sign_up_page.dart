import 'package:flutter/material.dart';
import 'package:trapp_flutter/models/dailyExpenses.dart';
import 'package:trapp_flutter/services/auth.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

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
  String lastName = '';
  String phone = '';
  String birthday = '';
  String gender = '';
  List dailyExpenses = [];
  List userGroups = [];


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgSignUp.jpeg'),
            fit: BoxFit.cover,
          )
      ),
      child:
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: _content(),
          )
        ),

    );

  }

  Widget _content(){
    return
    Container(
      padding: const EdgeInsets.all(22),
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
                    fontSize:MediaQuery.of(context).size.width/7,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.all(34),
                decoration: const BoxDecoration(
                    color: Colors.white,
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
                    Positioned(child: Text("Join us!",
                      style: TextStyle(
                        fontFamily: 'thaBold',
                        fontSize: MediaQuery.of(context).size.width/6,
                        color: const Color(0xff7B767D),
                      ),),
                      top: 550,),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.account_circle_rounded, color: Colors.grey),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            )
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintText: "Username",
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade50,
                        ),
                      ),
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      textCapitalization: TextCapitalization.words,
                      textAlign: TextAlign.center,
                      validator: (val) => val!.isEmpty ? 'Enter an username' : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.mail, color: Colors.grey),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            )
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
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
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      textCapitalization: TextCapitalization.words,
                      textAlign: TextAlign.center,
                      validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password_rounded, color: Colors.grey),
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
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      textCapitalization: TextCapitalization.words,
                      textAlign: TextAlign.center,
                      validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    RaisedButton(onPressed: ()async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth.registerWithEmailAndPassword(
                            email, password, name, lastName, phone, birthday, gender, dailyExpenses, userGroups);
                        if (result == null) {
                          setState(() {
                            loading = false;
                            error = 'Please supply a valid email';
                          });
                        }else{
                          Navigator.pop(context);
                        }
                      }
                    }, color: const Color(0xff00AFB9),
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                        child: const Center(child: Text('Sign Up', style: TextStyle( color: Color(0xffF3F9E3)),)))
                  ],
                ),
              ),

            ]

          )

        ),
      ),
    );

  }
}