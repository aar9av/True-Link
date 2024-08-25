import 'package:flutter/material.dart';
import 'package:true_link/Activities/ETHSection.dart';
import 'package:true_link/UI/Background.dart';
import 'package:true_link/UI/ThemeColors.dart';

class ETHHistory extends StatelessWidget {
  const ETHHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          const EthSection(),
          Center(
            child: Text(
              'ETH\nTransactions Page',
              style: TextStyle(
                color: ThemeColors.themeColor,
                fontSize: 36,
              ),
            ),
          )
        ],
      ),
    );
  }
}
