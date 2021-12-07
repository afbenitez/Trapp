import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trapp_flutter/models/place.dart';
import 'package:trapp_flutter/screens/places/overview.dart';
import 'package:trapp_flutter/screens/places/review.dart';

class TabMenu extends StatelessWidget {
  final Place place;
  const TabMenu({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(300),
            child: AppBar(
              backgroundColor: Color(0xffC7E7E9),
              bottom: const TabBar(
                labelColor: Color(0xff481620),
                indicatorColor: Color(0xff481620),
                tabs: [
                  Tab(text: 'Overview',),
                  Tab(text: 'Review',),
                ],
              ),
              flexibleSpace: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: size-50,
                        ),
                        Image(
                          image: AssetImage('assets/logo.png'),
                          width: 45,
                          height: 45,
                        ),
                      ],
                    ),
                    Text(
                      '${place.name}',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'thaBold',
                      ),
                    ),
                    SizedBox(
                      height: size/10,
                    ),
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: CachedNetworkImage(
                        placeholder: (context, url) => const Icon(Icons.error, size: 50,),
                        imageUrl: place.img,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Overview(place: place),
              Review(place: place),
            ],
          ),
          backgroundColor: Color(0xffC7E7E9),
        ),
      ),
    );
  }

}

