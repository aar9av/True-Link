import 'package:flutter/material.dart';
import 'ThemeInfo.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            color: ThemeInfo.bgColor,
          ),
          Positioned(
            top: 100,
            right: -50,
            child: Image.asset(
              ThemeInfo.appIcon,
              height: MediaQuery.of(context).size.height * 0.2,
              color: ThemeInfo.themeColor.withOpacity(0.15),
            ),
          ),
          Positioned(
            top: 220,
            right: 180,
            child: Image.asset(
              ThemeInfo.appIcon,
              height: MediaQuery.of(context).size.height * 0.05,
              color: ThemeInfo.themeColor.withOpacity(0.35),
            ),
          ),
          Positioned(
            top: 350,
            right: 200,
            child: Image.asset(
              ThemeInfo.appIcon,
              height: MediaQuery.of(context).size.height * 0.25,
              color: ThemeInfo.themeColor.withOpacity(0.20),
            ),
          ),
          Positioned(
            top: 580,
            right: 50,
            child: Image.asset(
              ThemeInfo.appIcon,
              height: MediaQuery.of(context).size.height * 0.1,
              color: ThemeInfo.themeColor.withOpacity(0.25),
            ),
          ),
        ],
      ),
    );
  }
}
