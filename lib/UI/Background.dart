import 'package:flutter/material.dart';
import 'ThemeColors.dart';

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
            color: ThemeColors.bgColor,
          ),
          Positioned(
            right: 0,
            top: 20,
            child: Image.asset(
              'assets/EthLogo.png',
              height: MediaQuery.of(context).size.height * 0.6,
              color: const Color.fromRGBO(120, 120, 120, 180),
              colorBlendMode: BlendMode.modulate,
            ),
          ),
        ],
      ),
    );
  }
}
