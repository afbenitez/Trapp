import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:trapp_flutter/models/dailyExpenses.dart';
import 'package:trapp_flutter/screens/budget/heading.dart';
import 'package:trapp_flutter/services/user_service.dart';

class Budget extends StatelessWidget {
  const Budget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return circularBar(context);
  }

  Widget circularBar(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEEEEEE),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: <Widget>[
                  Heading(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 35,
                  ),
                  const EnterBudget(),
                ],
              ),
            )),
      ),
    );
  }
}

class EnterBudget extends StatefulWidget {
  const EnterBudget({Key? key}) : super(key: key);

  @override
  _EnterBudgetState createState() => _EnterBudgetState();
}

class _EnterBudgetState extends State<EnterBudget> {
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

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  fetchUserInfo() {
    User? getUser = FirebaseAuth.instance.currentUser;
    userId = getUser!.uid;
    var document =
        FirebaseFirestore.instance.collection('users').doc(userId);
    document.get().then((u) {
      setState(() {
        firstName = u.get('firstName');
        lastName = u.get('lastName');
        email = u.get('email');
        phone = u.get('phone');
        birthday = u.get('birthday');
        gender = u.get('gender');
        _dailyExpensesList = u.get('dailyExpenses');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_dailyExpensesList.isEmpty)
        ? const CircularProgressIndicator()
        : Column(
            children: [
              Neumorphic(
                child: RaisedButton(
                  child: const Text(
                    '+',
                    style: TextStyle(
                      color: Color(0xffF3F9E3),
                      fontFamily: 'thaBold',
                    ),
                  ),
                  onPressed: () async {
                    await addDailyBudget(context);
                  },
                  color: const Color(0xff00AFB9),
                ),
              ),
              //TODO Esto es lo que se debe modificar en donde dice 'day 1' debe ir el 'dayNumber', y donde dice '900' debe ir 'amount'
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: _dailyExpensesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LinearPercentIndicator(
                      progressColor: const Color(0xff00AFB9),
                      backgroundColor: Colors.transparent,
                      lineHeight: 10,
                      percent: _dailyExpensesList[index]['amount'] / 20000,
                      animation: true,
                      animationDuration: 500,
                      leading: Text(
                        '${_dailyExpensesList[index]['dayNumber']}',
                        // ',',
                        style: const TextStyle(
                          fontFamily: 'thaRegular',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Text(
                        '${_dailyExpensesList[index]['amount']}',
                        style: const TextStyle(
                          fontFamily: 'thaRegular',
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
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
                      height: MediaQuery.of(context).size.height / 10,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18, fontFamily: 'thaRegular'),
                      decoration: const InputDecoration(
                        hintText: 'Day number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            )),
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
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'thaRegular',
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Amount',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            )),
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
                      height: MediaQuery.of(context).size.height / 15,
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
                  child: const Center(
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
