import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return home or authenticate depending on logged in status

    final user = Provider.of<User>(context);

    if (user == null)
      return Authenticate();
    else
      return Home();
  }
}
