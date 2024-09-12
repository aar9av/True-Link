import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:true_link/Activities/HomePage/HomePage.dart';
import 'package:true_link/UI/Background.dart';
import 'package:true_link/UI/ThemeInfo.dart';

import '../../Data&Methods/Users.dart';
import '../../LoginPage.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();
  bool gender = Users.currentUserData[0][3];
  bool isLoading = false;
  bool chkName = false;
  bool chkBio = false;
  XFile? avatar;

  @override
  initState() {
    super.initState();
    setInitialValue();
  }

  void setInitialValue() {
    name.text = Users.currentUserData[0][2];
    bio.text = Users.currentUserData[0][4];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                SizedBox(
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          await showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: ThemeInfo.gradientColor1,
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                ),
                                child: Wrap(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.photo_library, color: Colors.white,),
                                      title: const Text('Gallery', style: TextStyle(color: Colors.white,),),
                                      onTap: () async {
                                        Navigator.of(context).pop();
                                        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                        if (image != null) {
                                          setState(() {
                                            avatar = image;
                                          });
                                        }
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.camera_alt, color: Colors.white,),
                                      title: const Text('Camera', style: TextStyle(color: Colors.white,),),
                                      onTap: () async {
                                        Navigator.of(context).pop();
                                        final XFile? image = await picker.pickImage(source: ImageSource.camera);
                                        if (image != null) {
                                          setState(() {
                                            avatar = image;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 130,
                          width: 130,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            border: Border.all(
                              color: ThemeInfo.themeColor,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: avatar != null ?
                            Image.file(
                              File(avatar!.path),
                              fit: BoxFit.cover,
                              height: 60,
                              width: 60,
                            ) :
                            Image.network(
                              Users.currentUserData[0][5],
                              fit: BoxFit.cover,
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        Users.currentUserData[0][2],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: ThemeInfo.themeColor,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        Users.currentUserData[0][1],
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
                const SizedBox(height: 20),
                SizedBox(
                  height: 220,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        color: ThemeInfo.gradientColor2,
                        height: 40,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: name,
                          onChanged: (value) {
                            setState(() {
                              chkName = name.text.isEmpty;
                            });
                          },
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
                            enabledBorder: UnderlineInputBorder(
                              borderSide: chkName ? const BorderSide(color: Colors.redAccent) : const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: chkName ? const BorderSide(color: Colors.redAccent) : BorderSide(color: ThemeInfo.themeColor),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
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
                                activeColor: ThemeInfo.themeColor,
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
                                activeColor: ThemeInfo.themeColor,
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
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        color: ThemeInfo.gradientColor2,
                        height: 90,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          controller: bio,
                          maxLines: 10,
                          onChanged: (value) {
                            setState(() {
                              chkBio = bio.text.isEmpty;
                            });
                          },
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
                            enabledBorder: UnderlineInputBorder(
                              borderSide: chkBio ? const BorderSide(color: Colors.redAccent) : const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: chkBio ? const BorderSide(color: Colors.redAccent) : BorderSide(color: ThemeInfo.themeColor),
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
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: isLoading
                      ? null
                      : () async {
                    if (name.text.isNotEmpty && bio.text.isNotEmpty && (Users.currentUserData[0][2] != 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png' || avatar != null)) {
                      setState(() {
                        isLoading = true;
                      });
                      if (await Users.updateUser(name.text, gender, bio.text, avatar)) {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Unable to update profile!'),
                            backgroundColor:
                            ThemeInfo.gradientColor1.withOpacity(0.9),
                            margin: const EdgeInsets.all(10),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ThemeInfo.themeColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: ThemeInfo.themeColor.withOpacity(0.5),
                          blurRadius: 6,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: isLoading ? Center(
                      child: Image.asset(
                        ThemeInfo.loadingIcon,
                        height: 100,
                        color: ThemeInfo.gradientColor1,
                      ),
                    )
                        : const Center(
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
                GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ThemeInfo.gradientColor1,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: ThemeInfo.themeColor,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ThemeInfo.themeColor.withOpacity(0.5),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: ThemeInfo.themeColor,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
