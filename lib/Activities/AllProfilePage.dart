import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Data&Methods/AllUsers.dart';

class AllProfilePage extends StatefulWidget {
  const AllProfilePage({super.key});

  @override
  _AllProfilePageState createState() => _AllProfilePageState();
}

class _AllProfilePageState extends State<AllProfilePage> {
  bool isBioExpanded = false;
  int profileIndex = 0;
  bool isFirstTime = false;
  //bool matchRequest =

  void _toggleBio() {
    setState(() {
      isBioExpanded = !isBioExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            GestureDetector(
              onTap: _toggleBio,
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.primaryVelocity! < 0) {
                  setState(() {
                    profileIndex = (profileIndex + 1) % AllUsers.allUsers.length;
                  });
                }
                if (details.primaryVelocity! > 0) {
                  setState(() {
                    isFirstTime = false;
                  });
                }
              },
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Stack(
                  children: [
                    Image.asset(
                      AllUsers.allUsers[profileIndex]['profilePhoto'].toString(),
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
                            AllUsers.allUsers[profileIndex]['name'].toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: _toggleBio,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              child: Text(
                                AllUsers.allUsers[profileIndex]['bio'].toString(),
                                overflow: isBioExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                                maxLines: isBioExpanded ? null : 2,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => {
                setState(() {
                  isFirstTime = true;
                }),
              },
              child: Container(
                height: isFirstTime ? 0 : double.infinity,
                width: double.infinity,
                color: const Color(0xdd000000),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            CupertinoIcons.left_chevron,
                            color: Colors.white,
                            size: 36,
                          ),
                          Text(
                            'Swipe Left to skip\nto next Profile!!!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            CupertinoIcons.right_chevron,
                            color: Colors.white,
                            size: 36,
                          ),
                          Text(
                            'Swipe Right\nto get matched!!!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
