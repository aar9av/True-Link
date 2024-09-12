import 'package:flutter/material.dart';
import 'package:true_link/Activities/HomePage/MatchedUserSection.dart';
import 'package:true_link/Activities/Confession/PostPage.dart';
import 'package:true_link/Activities/Profile/AllProfilePage.dart';
import 'package:true_link/UI/Background.dart';
import 'package:true_link/UI/ThemeInfo.dart';

import '../../Data&Methods/Posts.dart';
import '../../Data&Methods/Requests.dart';
import '../../Data&Methods/Users.dart';
import '../Profile/EditProfile.dart';
import 'BottomNavBar.dart';
import 'Header.dart';
import 'OtherProfilesSection.dart';
import 'SearchBarWidget.dart';

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
                    ThemeInfo.gradientColor1,
                    ThemeInfo.gradientColor2,
                    ThemeInfo.gradientColor2,
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
                      color: ThemeInfo.themeColor.withOpacity(1),
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
              color: ThemeInfo.bgColor,
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
                              color: ThemeInfo.gradientColor1,
                              borderRadius: const BorderRadius.all(Radius.circular(3)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SearchBarWidget(),
                        Users.matchedUserData.isEmpty ?
                        const SizedBox() :
                        const MatchedUserSection(),
                        Requests.otherProfiles.isEmpty ?
                        const SizedBox() :
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
                        Requests.otherProfiles.isEmpty ?
                        const SizedBox() :
                        const OtherProfilesSection(),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const PostPage(isAll: false),));
                            setState(() {});
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
                                color: ThemeInfo.gradientColor2,
                                border: Border(
                                    bottom: BorderSide(
                                      color: ThemeInfo.themeColor,
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
                                    if (Posts.tagPosts.isNotEmpty)
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
                                  color: ThemeInfo.themeColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AllProfilePage(userID: -2),));
                            setState(() {});
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
                                color: ThemeInfo.gradientColor2,
                                border: Border(
                                    bottom: BorderSide(
                                      color: ThemeInfo.themeColor,
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
                                    if (Requests.matchRequests.isNotEmpty)
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
                                  color: ThemeInfo.themeColor,
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
                                builder: (context) => const AllProfilePage(userID: -3),
                              ),
                            );
                            setState(() {});
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
                              color: ThemeInfo.gradientColor2,
                              border: Border(
                                bottom: BorderSide(
                                  color: ThemeInfo.themeColor,
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
                                    if (Requests.pendingRequests.isNotEmpty)
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
                                  color: ThemeInfo.themeColor,
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
          Users.currentUserData[0][4] == '' || Users.currentUserData[0][5] == 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png' ?
          Container(
            height: double.infinity,
            width: double.infinity,
            color: ThemeInfo.gradientColor1.withOpacity(0.9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Text(
                  'Hi! ${Users.currentUserData[0][2]}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeInfo.themeColor,
                    fontSize: 30,
                  ),
                ),
                const Text(
                  '\nfirst complete your profile\nby tap on profile button\nappear in bottom\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 72,
                  color: ThemeInfo.themeColor,
                ),
              ],
            ),
          ) :
          const SizedBox(),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}