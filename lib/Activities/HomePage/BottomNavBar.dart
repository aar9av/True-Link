import 'package:flutter/material.dart';
import 'package:true_link/Activities/Profile/EditProfile.dart';
import '../../Initial Files/ThemeInfo.dart';
import '../../Data&Methods/Users.dart';
import '../Confession/PostPage.dart';
import '../Profile/AllProfilePage.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PostPage(isAll: true),));
                  setState(() {});
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AllProfilePage(userID: -4),));
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
    );
  }
}
