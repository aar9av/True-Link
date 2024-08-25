import 'package:flutter/material.dart';

import '../Data&Methods/UserData.dart';
import '../UI/ThemeColors.dart';

class EthSection extends StatelessWidget {
  const EthSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(
        top: 60,
        right: 20,
        left: 20,
      ),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(5, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/WalletEthLogo.png',
          ),
          Text(
            " ${UserData.ethBalance} ETH",
            style: TextStyle(
              color: ThemeColors.themeColor,
              fontSize: 36,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
