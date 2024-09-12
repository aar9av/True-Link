import 'dart:math';
import 'package:flutter/material.dart';
import 'package:true_link/Data&Methods/Requests.dart';

import '../../Initial Files/ThemeInfo.dart';
import '../Profile/AllProfilePage.dart';

class OtherProfilesSection extends StatefulWidget {
  const OtherProfilesSection({super.key});

  @override
  State<OtherProfilesSection> createState() => _OtherProfilesSectionState();
}

class _OtherProfilesSectionState extends State<OtherProfilesSection> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Requests.otherProfiles.isEmpty ?
      const SizedBox() :
      Stack(
        children: [
          Transform.rotate(
            angle: 5 * pi / 180,
            child: Container(
              height: 270,
              width: 180,
              margin: const EdgeInsets.only(left: 30, top: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ThemeInfo.themeColor,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: Image.network(
                  Requests.otherProfiles[1 % Requests.otherProfiles.length][5].toString(),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AllProfilePage(userID: -1),));
              setState(() {});
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
                      Requests.otherProfiles[0][5].toString(),
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
                            Requests.otherProfiles[0][2].toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            Requests.otherProfiles[0][4].toString(),
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
