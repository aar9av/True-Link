import 'package:flutter/material.dart';
import 'package:true_link/UI/Background.dart';
import 'package:true_link/UI/ThemeColors.dart';

class TagsPage extends StatelessWidget {
  const TagsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Center(
            child: Text(
              'Tags page',
              style: TextStyle(
                color: ThemeColors.themeColor,
                fontSize: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
