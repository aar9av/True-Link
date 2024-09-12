import 'dart:math';

import 'package:flutter/material.dart';
import 'package:true_link/Activities/PostPage.dart';
import 'package:true_link/Activities/AllProfilePage.dart';

import '../../Data&Methods/Chats.dart';
import '../../Data&Methods/Posts.dart';
import '../../Data&Methods/Requests.dart';
import '../../Data&Methods/Users.dart';
import '../../Initial Files/Background.dart';
import '../../Initial Files/ThemeInfo.dart';
import 'ChatPage.dart';
import 'EditProfile.dart';
import 'Header.dart';
import 'SearchBarWidget.dart';

class HomePage extends StatefulWidget {

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
                        // Slider Icon
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
                        // Search Bar
                        const SearchBarWidget(),
                        // Matched User Section
                        Users.matchedUserData.isEmpty ?
                        const SizedBox() :
                        (Chats.isBlock ?
                        SizedBox(
                          height: 150,
                          child: Center(
                            child: Image.asset(
                              ThemeInfo.loadingIcon,
                              height: 100,
                              color: ThemeInfo.themeColor,
                            ),
                          ),
                        ) :
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatPage(),)).then((_) async {
                                if(Chats.isBlock) {
                                  setState(() {});
                                  await Users.getUserData();
                                  setState(() {
                                    Chats.isBlock = false;
                                  });
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ThemeInfo.themeColor,
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(17),
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          Users.matchedUserData[0][5],
                                          fit: BoxFit.cover,
                                          height: 150,
                                          width: 150,
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
                                          child: Text(
                                            Users.matchedUserData[0][2],
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width - 200,
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'BIO',
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: ThemeInfo.themeColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 100,
                                        child: SingleChildScrollView(
                                          child: Text(
                                            Users.matchedUserData[0][4],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                        // Other User Section
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
                        Center(
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AllProfilePage(userID: -1),)).then((_) {
                                    setState(() {});
                                  });
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
                                                maxLines: 3,
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
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // Tag, Match Request, Pending Request Button
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PostPage(isAll: false),
                              ),
                            ).then((_) {
                              setState(() {});
                            });
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
                                    Posts.tagPosts.isNotEmpty ?
                                    Container(
                                      margin: const EdgeInsets.only(left: 5, bottom: 12),
                                      height: 4,
                                      width: 4,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ) :
                                    const SizedBox(),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AllProfilePage(userID: -2),)).then((_) {setState(() {});});
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
                            ).then((_) {
                              setState(() {});
                            });
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
          Users.currentUserData[0][4] == '' ?
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
      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ThemeInfo.gradientColor1,
          boxShadow: [
            BoxShadow(
              color: ThemeInfo.themeColor.withOpacity(0.5),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PostPage(isAll: true),)).then((_) {
                      setState(() {});
                    });
                  },
                  icon: const Icon(
                    Icons.short_text_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 3),
                IconButton(
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AllProfilePage(userID: -4),)).then((_) {
                      setState(() {});
                    });
                  },
                  icon: const Icon(
                    Icons.history_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
              ],
            ),
            Positioned(
              top: -30,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile(),));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ThemeInfo.gradientColor2,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(36),
                    boxShadow: [
                      BoxShadow(
                        color: ThemeInfo.themeColor.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(36),
                    child: Image.network(
                      Users.currentUserData[0][5],
                      fit: BoxFit.cover,
                      height: 72,
                      width: 72,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}