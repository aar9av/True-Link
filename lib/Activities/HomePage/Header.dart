import 'package:flutter/material.dart';

import '../../UI/ThemeInfo.dart';
import '../../Data&Methods/Users.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(
        top: 60,
        right: 20,
        left: 20,
      ),
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
          Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                Users.currentUserData[0][5],
                fit: BoxFit.cover,
                height: 60,
                width: 60,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi! ${Users.currentUserData[0][2]}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                Users.currentUserData[0][1],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: ThemeInfo.themeColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
