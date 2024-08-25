import 'package:flutter/material.dart';

import '../UI/ThemeColors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeColors.gradientColor1,
        boxShadow: [
          BoxShadow(
            color: ThemeColors.themeColor.withOpacity(0.5),
            blurRadius: 20,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {

                },
                icon: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 3),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.line_weight_sharp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Positioned(
            top: -30,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: ThemeColors.gradientColor2,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(36),
                boxShadow: [
                  BoxShadow(
                    color: ThemeColors.themeColor.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(36),
                child: Image.asset(
                  'assets/CurrentUserProfilePicture.jpg',
                  width: 72,
                  height: 72,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
