import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ActivitySelect extends StatefulWidget {
  const ActivitySelect({Key? key}) : super(key: key);

  @override
  _ActivitySelectState createState() => _ActivitySelectState();
}

class _ActivitySelectState extends State<ActivitySelect> {

  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Center(
                  child: Row(
                    children:const <Widget> [
                      Text('Select an activity',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'thaBold',
                        ),
                      ),
                      SizedBox(
                        width: 55,
                      ),
                      Image(
                        image: AssetImage('assets/logo.png'),
                        width: 50,
                        height: 50,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 35,
                ),
                Text(
                  'Aquí va el nombre de la actividad',
                   style: TextStyle(
                     fontFamily: 'thaBold',
                     fontSize: 25,
                   ),
                ),
                //Aquí va la imagen de la actividad (la misma imagen del viaje)
                Image(
                  image: AssetImage('assets/logo.png'),
                  width: 250,
                  height: 250,
                ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 35,
                  ),
                  const Text(
                    'Aquí va el precio de la actividad',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'thaBold'
                    ),
                  ),
                  Row(
                    children: [
                      Neumorphic(
                        child: RaisedButton(
                          onPressed: (){
                            addDialog(context);
                            setState(() => pressed = true);
                          },
                          child: Center(
                            child: Text(
                              'Add',
                              style: TextStyle(
                                fontFamily: 'thaBold'
                              ),
                            ),
                          ),
                          color: const Color(0xff00AFB9),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Neumorphic(
                        child: RaisedButton(
                          onPressed: pressed ? (){
                            deleteDialog(context);
                            setState(() => pressed = false);
                          } : null,
                          child: Center(
                            child: Text(
                                'Delete',
                              style: TextStyle(
                                fontFamily: 'thaBold'
                              ),
                            ),
                          ),
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ));
  }

  addDialog(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Text(
          'The activity has been added'
        ),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
                Navigator.of(context).pop();
              },
            child: const Center(
              child: Text(
                'Ok',
              ),
            ),
          ),
        ],
      );
    });
  }

  deleteDialog(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Text(
            'The activity has been deleted'
        ),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Center(
              child: Text(
                'Ok',
              ),
            ),
          ),
        ],
      );
    });
  }
}
