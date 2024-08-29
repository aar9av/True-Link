import 'package:flutter/material.dart';
import 'package:true_link/Activities/HomePage/HomePage.dart';
import 'package:true_link/UI/Background.dart';
import 'package:true_link/UI/ThemeColors.dart';

import '../../Data&Methods/Users.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();
  bool? gender = Users.currentUserData['gender'];

  @override
  Widget build(BuildContext context) {
    name.text = Users.currentUserData['username'];
    bio.text = Users.currentUserData['bio'];
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 130,
                        width: 130,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            border: Border.all(
                              color: ThemeColors.themeColor,
                              width: 2,
                            )
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: Image.network(
                            Users.currentUserData['profilepicture'],
                            fit: BoxFit.cover,
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ),
                      Text(
                        Users.currentUserData['username'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: ThemeColors.themeColor,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        Users.currentUserData['email'],
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 220,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        color: ThemeColors.gradientColor2,
                        height: 40,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: name,
                          decoration: InputDecoration(
                            hintText: 'Enter Full Name',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                            ),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ThemeColors.themeColor,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Gender    ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: RadioListTile<bool>(
                                title: const Text(
                                  'Male',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                value: true,
                                groupValue: gender,
                                activeColor: ThemeColors.themeColor,
                                onChanged: (value) {
                                  setState(() {
                                    gender = true;
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: RadioListTile<bool>(
                                title: const Text(
                                  'Female',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                value: false,
                                groupValue: gender,
                                activeColor: ThemeColors.themeColor,
                                onChanged: (value) {
                                  setState(() {
                                    gender = false;
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        color: ThemeColors.gradientColor2,
                        height: 90,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          controller: bio,
                          maxLines: 10,
                          decoration: InputDecoration(
                            hintText: 'Write something about yourself...',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                            ),
                            prefixIcon: const Icon(
                              Icons.short_text_rounded,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ThemeColors.themeColor,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    print(name.text);
                    print(gender);
                    print(bio.text);
                    Navigator.pop(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),));
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ThemeColors.themeColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: ThemeColors.themeColor.withOpacity(0.5),
                          blurRadius: 6,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Save Profile',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
