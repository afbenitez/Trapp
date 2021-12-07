import 'package:flutter/material.dart';
import 'package:trapp_flutter/models/place.dart';

class Overview extends StatelessWidget {
  final Place? place;
  const Overview({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height/15,
          ),
          Row(
            children: [
              Text(
                'Direction:',
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'thaBold',

                ),
              ),
              Text(
                '${place!.address}',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'thaRegular',
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height/15,
          ),
          Row(
            children: [
              Text(
                'Latitude:',
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'thaBold',
                ),
              ),
              Text(
                '${place!.latitude}',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'thaRegular',
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height/15,
          ),
          Row(
            children: [
              Text(
                'Longitude:',
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'thaBold',
                ),
              ),
              Text(
                '${place!.longitude}',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'thaRegular',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
