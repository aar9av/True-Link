import "package:flutter/material.dart";
import 'package:true_link/UI/ThemeColors.dart';

import 'Activities/HomePage.dart';

void main() {
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

