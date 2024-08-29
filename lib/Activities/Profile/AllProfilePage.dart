import 'package:flutter/material.dart';
import 'package:true_link/UI/Background.dart';
import 'package:true_link/UI/ThemeColors.dart';
import '../../Data&Methods/Users.dart';

class AllProfilePage extends StatefulWidget {
  final String userID;

  const AllProfilePage({super.key, required this.userID});

  @override
  _AllProfilePageState createState() => _AllProfilePageState();
}

class _AllProfilePageState extends State<AllProfilePage> {
  bool isBioExpanded = false;
  int profileIndex = 0;
  bool isFirstTime = false;
  List<dynamic> displayUsers = [];
  bool reqButton = true;
  String matchBtnText = "Request Match +";

  @override
  Widget build(BuildContext context) {
    if(widget.userID == "All Profiles") {
      displayUsers = Users.otherProfiles;
    } else if(widget.userID == "Match Requests") {
      displayUsers = Users.matchRequests;
      matchBtnText = "Accept Request +";
    } else if(widget.userID == "Pending Requests") {
      displayUsers = Users.pendingRequests;
      matchBtnText = "Cancel Request";
    } else if(widget.userID == "User History") {
      displayUsers = Users.userHistory;
      matchBtnText = "Reconnect +";
    } else {
      for(int i=0; i<Users.allUserData.length; ++i) {
        displayUsers = [];
        if(Users.allUserData[i]['userID'] == widget.userID) {
          displayUsers.add(Users.allUserData[i]);
          break;
        }
      }
    }
    if(displayUsers.isNotEmpty) {
      if (displayUsers[profileIndex]['gender'] == Users.currentUserData['gender'] ||
          displayUsers[profileIndex]['userID'] == Users.matchedUserData['userID']) {
        reqButton = false;
      }
    }
    return Scaffold(
      body: displayUsers.isEmpty ?
      Stack(
        children: [
          const Background(),
          Center(
            child: Text(
              'NULL',
              style: TextStyle(
                color: ThemeColors.themeColor,
                fontSize: 72,
              ),
            ),
          ),
        ],
      ) :
      Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isBioExpanded = !isBioExpanded;
            });
          },
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity! < 0) {
              setState(() {
                profileIndex = (profileIndex + 1) % displayUsers.length;
                isBioExpanded = false;
              });
            } else if (details.primaryVelocity! > 0) {
              setState(() {
                profileIndex = (profileIndex - 1 + displayUsers.length) % displayUsers.length;
                isBioExpanded = false;
              });
            }
          },
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                displayUsers[profileIndex]['profilepicture'] == null ?
                Image.asset(
                  'assets/ProfilePhoto1.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ) :
                Image.network(
                  displayUsers[profileIndex]['profilepicture'].toString(),
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
                  bottom: reqButton ? 60 : 10,
                  left: 10,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayUsers[profileIndex]['username'].toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: ThemeColors.themeColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isBioExpanded = !isBioExpanded;
                          });
                        },
                        child: Text(
                          displayUsers[profileIndex]['bio'].toString(),
                          overflow: isBioExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                          maxLines: isBioExpanded ? null : 2,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: reqButton ? 10 : 0,
                  left: 10,
                  right: 10,
                  child: SizedBox(
                    height: reqButton ? 40 : 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              profileIndex = (profileIndex + 1) % displayUsers.length;
                              isBioExpanded = false;
                            });
                          },
                          child: const Text(
                            'Skip >>',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Divider(
                          height: 5,
                          color: Colors.white,
                        ),
                        TextButton(
                          onPressed: () {

                          },
                          child: Text(
                            matchBtnText,
                            style: TextStyle(
                              color: ThemeColors.themeColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
