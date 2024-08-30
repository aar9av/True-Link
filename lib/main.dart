import "package:flutter/material.dart";
import 'package:true_link/UI/ThemeColors.dart';
import 'package:postgres/postgres.dart';

import 'Activities/HomePage/HomePage.dart';
import 'Data&Methods/Users.dart';
import 'Hidden Files/Routes.dart';

Future<void> main() async {
  await Users.getUserData();
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

