import 'package:flutter/material.dart';
import 'package:true_link/Activities/HomePage/MatchedUserSection.dart';
import 'package:true_link/Activities/PostPage.dart';
import 'package:true_link/Activities/Profile/AllProfilePage.dart';
import 'package:true_link/UI/Background.dart';
import 'package:true_link/UI/ThemeColors.dart';

import '../../Data&Methods/Users.dart';
import '../Profile/EditProfile.dart';
import 'BottomNavBar.dart';
import 'Header.dart';
import 'OtherProfilesSection.dart';
import 'SearchBarWidget.dart';
import '../Tags.dart';

class HomePage extends StatefulWidget {
  static bool isSearchOn = false;

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              GestureDetector(
                onVerticalDragEnd: (DragEndDetails details) {
                  if (details.velocity.pixelsPerSecond.dy > 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditProfile()),
                    );
                  }
                },
                child: const Header(),
              ),
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
          Container(
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
                        const SizedBox(
                          height: 10,
                        ),
                        const SearchBarWidget(),
                        Users.matchedUserData.isEmpty ?
                        Container(
                          height: 0,
                        ) :
                        const MatchedUserSection(),
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: const Text(
                            'ALL PROFILES',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Users.otherProfiles.isEmpty ?
                        Container(
                          height: 0,
                        ) :
                        const OtherProfilesSection(),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage(isAll: false),));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                              top: 6,
                            ),
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            height: 36,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: ThemeColors.gradientColor2,
                                border: Border(
                                    bottom: BorderSide(
                                      color: ThemeColors.themeColor,
                                      width: 0.5,
                                    )
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Tags',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    if (Users.tagPosts.isNotEmpty)
                                      Container(
                                        margin: const EdgeInsets.only(left: 5, bottom: 12),
                                        height: 4,
                                        width: 4,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_outlined,
                                  color: ThemeColors.themeColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AllProfilePage(userID: "Match Requests"),));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                              top: 6,
                            ),
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            height: 36,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: ThemeColors.gradientColor2,
                                border: Border(
                                    bottom: BorderSide(
                                      color: ThemeColors.themeColor,
                                      width: 0.5,
                                    )
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Match Requests',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    if (Users.matchRequests.isNotEmpty)
                                      Container(
                                        margin: const EdgeInsets.only(left: 5, bottom: 12),
                                        height: 4,
                                        width: 4,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_outlined,
                                  color: ThemeColors.themeColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AllProfilePage(userID: "Pending Requests"),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                              top: 6,
                            ),
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            height: 36,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ThemeColors.gradientColor2,
                              border: Border(
                                bottom: BorderSide(
                                  color: ThemeColors.themeColor,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Pending Requests',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    if (Users.pendingRequests.isNotEmpty)
                                      Container(
                                        margin: const EdgeInsets.only(left: 5, bottom: 12),
                                        height: 4,
                                        width: 4,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_outlined,
                                  color: ThemeColors.themeColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}