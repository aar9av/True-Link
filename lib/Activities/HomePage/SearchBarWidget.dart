import 'dart:math';

import 'package:flutter/material.dart';
import 'package:true_link/Activities/Profile/AllProfilePage.dart';

import '../../UI/ThemeColors.dart';
import '../../Data&Methods/Users.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController findValue = TextEditingController();
  List<dynamic> searchedUser = [];
  late final FocusNode _searchFocusNode = FocusNode();
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: ThemeColors.themeColor.withOpacity(0.5),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            focusNode: _searchFocusNode,
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
                  color: ThemeColors.themeColor,
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
        SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: ThemeColors.gradientColor2.withOpacity(0.75),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            height: min(searchedUser.length * 80, 200),
            child: ListView.builder(
              itemCount: searchedUser.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    String userID = searchedUser[index]['userID'].toString();
                    setState(() {
                      findValue.clear();
                      searchedUser.clear();
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AllProfilePage(userID: userID),));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        searchedUser[index]['profilepicture'],
                      ),
                    ),
                    title: Text(
                      searchedUser[index]['username'],
                      style: TextStyle(
                        color: ThemeColors.themeColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      searchedUser[index]['bio'],
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
      if(value == "") {
        searchedUser.clear();
      } else {
        searchedUser = Users.allUserData.where((user) {
          return user['username'].toLowerCase().contains(value);
        }).toList();
      }
    });
  }
}
