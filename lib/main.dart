import "package:flutter/material.dart";
import 'package:true_link/UI/ThemeColors.dart';

import 'Activities/HomePage/HomePage.dart';
import 'Data&Methods/Users.dart';

Future<void> main() async {
  if(await Users.getUserData()) {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: ThemeColors.gradientColor1,
          foregroundColor: ThemeColors.themeColor,
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
    );
  }
}

