import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:trapp_flutter/models/dailyExpenses.dart';
import 'package:trapp_flutter/screens/budget/heading.dart';
import 'package:trapp_flutter/services/auth.dart';
import 'package:trapp_flutter/services/user_service.dart';

final AuthService _auth = AuthService();

class Budget extends StatelessWidget {
  const Budget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return circularBar(context);
  }

  Widget circularBar(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffEEEEEE),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: <Widget>[
                  Heading(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 35,
                  ),
                  enterBudget(),
                ],
              ),
            )),
      ),
    );
  }
}

class enterBudget extends StatefulWidget {
  const enterBudget({Key? key}) : super(key: key);

  @override
  _enterBudgetState createState() => _enterBudgetState();
}

class _enterBudgetState extends State<enterBudget> {
  int counter = 0;
  String userId = '';
  int _dayNumber = 0;
  int _amount = 0;
  String plansId = '';
  List _dailyExpensesList = [];
  List usersGroup = [];
  final _formKey = GlobalKey<FormState>();

  var firstName = '';
  var lastName = '';
  var email = '';
  var phone = '';
  var birthday = '';
  var gender = '';

  void initState() {
    super.initState();
    fetchUserInfo();
  }

  fetchUserInfo() async {
    User? getUser = FirebaseAuth.instance.currentUser;
    userId = getUser!.uid;
    var document = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots();
    document.forEach((element) {
      firstName = element['firstName'];
      lastName = element['lastName'];
      email = element['email'];
      phone = element['phone'];
      birthday = element['birthday'];
      gender = element['gender'];
      _dailyExpensesList = element['dailyExpenses'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Neumorphic(
            child: RaisedButton(
              child: Text(
                '+',
                style: TextStyle(
                  color: Color(0xffF3F9E3),
                  fontFamily: 'thaBold',
                ),
              ),
              onPressed: () async {
                   await addDailyBudget(context);
                 },
              color: Color(0xff00AFB9),
            ),
          ),
        //Esto es lo que se debe modificar en donde dice 'day 1' debe ir el 'dayNumber',
        //y donde dice '900' debe ir 'amount'
        LinearPercentIndicator(
          progressColor: Color(0xff00AFB9),
          backgroundColor: Colors.transparent,
          lineHeight: 10,
          percent: 200000 / 2000000,
          animation: true,
          animationDuration: 4000,
          leading: Text(
            'day 1',
            style: TextStyle(
              fontFamily: 'thaRegular',
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          trailing: Text(
            '900',
            style: TextStyle(
              fontFamily: 'thaRegular',
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> addDailyBudget(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              content: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Submit daily expenses',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                        fontFamily: 'thaBold',
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height /10,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontFamily: 'thaRegular'),
                      decoration: InputDecoration(
                        hintText: 'Day number',
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
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter the day number (1,2,3)' : null,
                      onChanged: (val) {
                        setState(() {
                          _dayNumber = int.parse(val);
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'thaRegular',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Amount',
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
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter the amount)' : null,
                      onChanged: (val) {
                        setState(() {
                          _amount = int.parse(val);
                        });
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height /15,
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                RaisedButton(
                  onPressed: () {
                    DailyExpenses dailyExpenses = DailyExpenses(
                        amount: _amount, day: _dayNumber, plansId: plansId);
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop();
                    }
                    _dailyExpensesList.add(dailyExpenses.toJson());
                    UserService(uid: userId).updateUserData(
                        firstName,
                        lastName,
                        phone,
                        birthday,
                        email,
                        gender,
                        _dailyExpensesList,
                        usersGroup);
                  },
                  child: Center(
                    child: Text(
                      'Submit',
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
