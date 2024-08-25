import 'dart:math';
import 'package:flutter/material.dart';

import '../../UI/ThemeColors.dart';
import '../../Data&Methods/Users.dart';
import '../Profile/AllProfilePage.dart';

class OtherProfilesSection extends StatelessWidget {
  const OtherProfilesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Transform.rotate(
            angle: 5 * pi / 180,
            child: Container(
              height: 270,
              width: 180,
              margin: const EdgeInsets.only(left: 30, top: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ThemeColors.themeColor,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: Image.network(
                  Users.otherProfiles[1 % Users.otherProfiles.length]['profilepicture'].toString(),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AllProfilePage(userID: ""),));
            },
            child: Container(
              height: 300,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: Stack(
                  children: [
                    Image.network(
                      Users.otherProfiles[0]['profilepicture'].toString(),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent,
                            Color(0xbb000000),
                            Color(0xee000000),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Users.otherProfiles[0]['username'].toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            Users.otherProfiles[0]['bio'].toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
