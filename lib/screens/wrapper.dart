import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trapp_flutter/models/user_fb.dart';
import 'package:trapp_flutter/screens/authentication/authenticate.dart';
import 'package:trapp_flutter/screens/home/home.dart';
import 'package:trapp_flutter/screens/home/home_logged.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User_fb?>(context);

    if (user == null) {
      return const Home();
    } else {
      return const HomeLogged();
    }
  }
}
