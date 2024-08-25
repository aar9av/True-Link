import 'package:flutter/material.dart';
import 'package:true_link/Activities/Profile/EditProfile.dart';
import '../../UI/ThemeColors.dart';
import '../../Data&Methods/Users.dart';

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
        color: ThemeColors.gradientColor1,
        boxShadow: [
          BoxShadow(
            color: ThemeColors.themeColor.withOpacity(0.5),
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

                },
                icon: const Icon(
                  Icons.short_text_outlined,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 3),
              IconButton(
                onPressed: () {},
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
                    color: ThemeColors.gradientColor2,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(36),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColors.themeColor.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: Users.currentUserData['profilepicture'] == null ?
                  Image.asset(
                    'assets/CurrentUserProfilePicture.jpg',
                    fit: BoxFit.cover,
                    height: 72,
                    width: 72,
                  ) :
                  Image.network(
                    Users.currentUserData['profilepicture'],
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
