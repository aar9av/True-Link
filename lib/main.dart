import "package:flutter/material.dart";

import 'Activities/HomePage/HomePage.dart';
import 'Data&Methods/Users.dart';

Future<void> main() async {
  if(await Users.getAllUserData() == true) {
    print("Success");
  } else {
    print("Unable to load All Users");
  }
  runApp(const TrueLink());
}

class TrueLink extends StatelessWidget {
  const TrueLink({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

