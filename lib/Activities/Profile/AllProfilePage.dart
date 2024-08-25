import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  dynamic displayUser;

  @override
  Widget build(BuildContext context) {
    if(widget.userID.isEmpty) {
      displayUser = Users.otherProfiles[profileIndex];
    } else {
      for(int i=0; i<Users.allUserData.length; ++i) {
        if(Users.allUserData[i]['userID'] == widget.userID) {
          displayUser = Users.allUserData[i];
          break;
        }
      }
    }
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isBioExpanded = !isBioExpanded;
            });
          },
          onHorizontalDragEnd: (DragEndDetails details) {
            if(widget.userID == "") {
              if (details.primaryVelocity! < 0) {
                setState(() {
                  profileIndex = (profileIndex + 1) % Users.otherProfiles.length;
                });
              }
              if (details.primaryVelocity! > 0) {
                setState(() {
                  profileIndex = (profileIndex - 1 + Users.otherProfiles.length) % Users.otherProfiles.length;
                });
              }
            }
          },
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                displayUser['profilepicture'] == null ?
                Image.asset(
                  'assets/ProfilePhoto1.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ) :
                Image.network(
                  displayUser['profilepicture'].toString(),
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
                        displayUser['username'].toString(),
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
                          displayUser['bio'].toString(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
