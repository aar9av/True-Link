import 'dart:math';

import 'package:flutter/material.dart';
import 'package:true_link/Activities/Profile/AllProfilePage.dart';

import '../../UI/ThemeInfo.dart';
import '../../Data&Methods/Users.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final focusScopeNode = FocusScopeNode();
  TextEditingController findValue = TextEditingController();
  List<dynamic> searchedUser = [];
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FocusScope(
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: ThemeInfo.themeColor.withOpacity(0.5),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: findValue,
              onChanged: (value) {
                setState(() {
                  isSearch = (value != "");
                });
                findUser(value);
              },
              decoration: InputDecoration(
                hintText: 'Search Profile...',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                  wordSpacing: 1,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: ThemeInfo.themeColor,
                    width: 2.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              ),
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: ThemeInfo.gradientColor2.withOpacity(0.75),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            height: min(searchedUser.length * 80, 200),
            child: ListView.builder(
              itemCount: searchedUser.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    focusScopeNode.unfocus();
                    int userID = searchedUser[index][0];
                    setState(() {
                      findValue.clear();
                      searchedUser.clear();
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AllProfilePage(userID: userID),));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        searchedUser[index][5],
                      ),
                    ),
                    title: Text(
                      searchedUser[index][2],
                      style: TextStyle(
                        color: ThemeInfo.themeColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      searchedUser[index][1],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void findUser(String value) {
    setState(() {
      value = value.toLowerCase();
      searchedUser.clear();
      for(int i=0; i<Users.allUserData.length; ++i) {
        if(Users.allUserData[i][2].toLowerCase().contains(value)) {
          searchedUser.add(Users.allUserData[i]);
        }
      }
      if (value.isEmpty) {
        searchedUser.clear();
      }
    });
  }
}
