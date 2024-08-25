import 'package:flutter/material.dart';
import 'package:true_link/Activities/ETHSection.dart';
import 'package:true_link/Activities/MatchedUserSection.dart';
import 'package:true_link/UI/Background.dart';
import 'package:true_link/UI/ThemeColors.dart';

import 'BottomNavBar.dart';
import 'ETHHistory.dart';
import 'OtherProfilesSection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ThemeColors.gradientColor1,
                    ThemeColors.gradientColor2,
                    ThemeColors.gradientColor2,
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              const EthSection(),
              Container(
                height: 100,
                width: 200,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColors.themeColor.withOpacity(1),
                      blurRadius: 50,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ],
          ),
          GestureDetector(
            onVerticalDragEnd: (DragEndDetails details) {
              if (details.velocity.pixelsPerSecond.dy > 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ETHHistory()),
                );
              }
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.only(
                top: 170,
              ),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ThemeColors.bgColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
              child: Stack(
                children: [
                  const Background(),
                  SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 6,
                              width: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ThemeColors.gradientColor1,
                                borderRadius: const BorderRadius.all(Radius.circular(3)),
                              ),
                            ),
                          ),
                          const MatchedUserSection(),
                          Container(
                            margin: const EdgeInsets.all(20),
                            child: const Text(
                              'OTHER PROFILES',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const OtherProfilesSection(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}