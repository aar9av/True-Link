import 'package:flutter/material.dart';
import 'package:true_link/Data&Methods/Requests.dart';
import '../../Data&Methods/Users.dart';
import '../../Initial Files/Background.dart';
import '../../Initial Files/ThemeInfo.dart';

class AllProfilePage extends StatefulWidget {
  final int userID;

  const AllProfilePage({super.key, required this.userID});

  @override
  _AllProfilePageState createState() => _AllProfilePageState();
}

class _AllProfilePageState extends State<AllProfilePage> {
  bool isBioExpanded = false;
  int profileIndex = 0;
  bool isFirstTime = false;
  List<dynamic> displayUsers = [];
  String matchBtnText = "";
  bool isLoading = true;
  bool isMatchLoading = false;

  @override
  initState() {
    super.initState();
    getDisplayUsers();
  }

  Future<void> getDisplayUsers() async {
    if(widget.userID == -1) {
      displayUsers = Requests.otherProfiles;
      matchBtnText = "Request Match +";
    } else if(widget.userID == -2) {
      displayUsers = Requests.matchRequests;
      matchBtnText = "Accept Request +";
    } else if(widget.userID == -3) {
      displayUsers = Requests.pendingRequests;
      matchBtnText = "Cancel Request";
    } else if(widget.userID == -4) {
      if(Requests.userHistory.length == 0) {
        if(!await Requests.getUserHistory()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Unable to fetch history !!!',
              ),
              backgroundColor: ThemeInfo.gradientColor1.withOpacity(0.9),
              margin: const EdgeInsets.all(10),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
      displayUsers = Requests.userHistory;
      matchBtnText = "Reconnect +";
    } else {
      for(int i=0; i<Users.allUserData.length; ++i) {
        displayUsers = [];
        if(Users.allUserData[i][0] == widget.userID) {
          displayUsers.add(Users.allUserData[i]);
          for(int j=0; j<Requests.otherProfiles.length; ++j) {
            if(displayUsers[0][0] == Requests.otherProfiles[j][0]) {
              matchBtnText = "Request Match +";
              break;
            }
          }
          for(int j=0; j<Requests.matchRequests.length; ++j) {
            if(displayUsers[0][0] == Requests.matchRequests[j][0]) {
              matchBtnText = "Accept Request +";
              break;
            }
          }
          for(int j=0; j<Requests.pendingRequests.length; ++j) {
            if(displayUsers[0][0] == Requests.pendingRequests[j][0]) {
              matchBtnText = "Cancel Request +";
              break;
            }
          }
          for(int j=0; j<Requests.userHistory.length; ++j) {
            if(displayUsers[0][0] == Requests.userHistory[j][0]) {
              matchBtnText = "Reconnect +";
              break;
            }
          }
          break;
        }
      }
    }
    if(displayUsers.isNotEmpty) {
      if (displayUsers[profileIndex][3] == Users.currentUserData[0][3] ||
          displayUsers[profileIndex][0] == Users.currentUserData[0][6]) {
        matchBtnText = "";
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: displayUsers.isEmpty ?
      Stack(
        children: [
          const Background(),
          Center(
            child: isLoading ?
            Image.asset(
              ThemeInfo.loadingIcon,
              height: 100,
              color: ThemeInfo.themeColor,
            ) :
            Text(
              'No profiles\nto show!!!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeInfo.themeColor,
                fontSize: 36,
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
                Image.network(
                  displayUsers[profileIndex][5].toString(),
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
                  bottom: matchBtnText != "" ? 60 : 10,
                  left: 10,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayUsers[profileIndex][2].toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: ThemeInfo.themeColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        displayUsers[profileIndex][4].toString(),
                        overflow: isBioExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                        maxLines: isBioExpanded ? null : 2,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: matchBtnText != "" ? 10 : 0,
                  left: 10,
                  right: 10,
                  child: SizedBox(
                    height: matchBtnText != "" ? 40 : 0,
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
                        isMatchLoading ?
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Image.asset(
                            ThemeInfo.loadingIcon,
                            height: 100,
                            color: ThemeInfo.themeColor,
                          ),
                        ) :
                        TextButton(
                          onPressed: () async {
                            if(matchBtnText == "Request Match +" || matchBtnText == "Reconnect +") {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Warning',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    content: const Text(
                                      'If you send a match request to another user, and the other user accept your request. Then your current partner will automatically blocked.',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: ThemeInfo.gradientColor1,
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: ThemeInfo.themeColor,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          if(!isMatchLoading) {
                                            setState(() {
                                              isMatchLoading = true;
                                            });
                                            Navigator.pop(context);
                                            if (!await Requests.addRequest(
                                                displayUsers[profileIndex][0])) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: const Text(
                                                    'Unable to send your request!!!',
                                                  ),
                                                  backgroundColor: ThemeInfo
                                                      .gradientColor1
                                                      .withOpacity(0.9),
                                                  margin: const EdgeInsets.all(
                                                      10),
                                                  behavior: SnackBarBehavior
                                                      .floating,
                                                ),
                                              );
                                            }
                                            getDisplayUsers();
                                            setState(() {
                                              isMatchLoading = false;
                                            });
                                          }
                                        },
                                        child: Text(
                                          matchBtnText,
                                          style: const TextStyle(
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            else if (matchBtnText == "Cancel Request") {
                              setState(() {
                                isMatchLoading = true;
                              });
                              if(!await Requests.cancelRequest(displayUsers[profileIndex][0])) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Unable to cancel this profile!!!',
                                    ),
                                    backgroundColor: ThemeInfo.gradientColor1.withOpacity(0.9),
                                    margin: const EdgeInsets.all(10),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                              getDisplayUsers();
                              setState(() {
                                isMatchLoading = false;
                              });
                            }
                            else if (matchBtnText == "Accept Request +") {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Warning',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    content: const Text(
                                      'If you accept this match request. Then current partner will automatically blocked.',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: ThemeInfo.gradientColor1,
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: ThemeInfo.themeColor,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          if(!isMatchLoading) {
                                            setState(() {
                                              isMatchLoading = true;
                                            });
                                            Navigator.pop(context);
                                            if(!await Requests.acceptRequest(displayUsers[profileIndex])) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: const Text(
                                                    'Unable to match your request!!!',
                                                  ),
                                                  backgroundColor: ThemeInfo.gradientColor1.withOpacity(0.9),
                                                  margin: const EdgeInsets.all(10),
                                                  behavior: SnackBarBehavior.floating,
                                                ),
                                              );
                                            }
                                            getDisplayUsers();
                                            setState(() {
                                              isMatchLoading = false;
                                            });
                                          }
                                        },
                                        child: Text(
                                          matchBtnText,
                                          style: const TextStyle(
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Text(
                            matchBtnText,
                            style: TextStyle(
                              color: ThemeInfo.themeColor,
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
