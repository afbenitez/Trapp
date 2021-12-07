import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trapp_flutter/models/trip.dart';

class TripDetail extends StatelessWidget {
  const TripDetail({Key? key, required this.trip}) : super(key: key);

  final Trip trip;

  getDestination(){
    CollectionReference cities = FirebaseFirestore.instance.collection('cities');
    // print('hola ${trip.destination}');
  }

  @override
  Widget build(BuildContext context) {
    var format = NumberFormat("#,###,###.#","en_ES");
    double size = MediaQuery.of(context).size.height/3;
    int idPlan = 101;
    return Container(
      color: const Color(0xFFC7E7E9),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
          child: Column(
            children: [
                Container(
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(trip.img),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // child: Text(places[index].name)
                  child: const SizedBox(
                    width: 300,
                    height: 300,
                  ),
                ),
              SizedBox(
                height: size/5,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size/8,
                  ),
                  Text(
                    'Price',
                    style: TextStyle(
                      fontFamily: 'thaBold',
                      color: Colors.black,
                      fontSize: size/9,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: size/9,
                  ),
                  Text(
                      '${format.format(trip.price)} COP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'thaRegular',
                      color: Colors.black38,
                      fontSize: size/10,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size/5,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size/8,
                  ),
                  Text(
                    'Calification',
                    style: TextStyle(
                      fontFamily: 'thaBold',
                      fontSize: size/9,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: size/9,
                  ),
                  Text(
                    '${trip.reviews}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'thaRegular',
                      color: Colors.black38,
                      fontSize: size/10,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size/5,
              ),
              ElevatedButton(
                  onPressed: (){
                    updatePlansMario(trip.price);

                  },
                  child: Text(
                    'Select',
                    style: TextStyle(
                      fontSize: size/10,
                      fontFamily: 'thaRegular',
                    ),
                  ),
              )
            ],
          ),
      ),
    );
  }

  Future<void> updatePlansMario(int price) async{
    int idPlan=0;
    DateTime now = DateTime.now();
    CollectionReference plans = FirebaseFirestore.instance.collection('plansMario');
    plans.get().then((value) async {
      // print('valor actual ${value.docs.length}');
      idPlan = value.docs.length+1;
      // print(idPlan);
      return await plans.doc('plan_$idPlan').set({
        'active': true,
        'activities': [44, 60, 70, 80],
        'dailyExpenses': [],
        'endDate': '31/12/2021',
        'items': ['Toasted Vanilla', 'Riluzole', 'Citalopram', 'Maleta'],
        'name': 'plan $idPlan',
        'price': price,
        'startDate': '${now.day}/${now.month}/${now.year}'
      });
    });

  }
}


