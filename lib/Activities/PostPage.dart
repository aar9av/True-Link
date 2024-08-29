import 'package:flutter/material.dart';
import 'package:true_link/UI/Background.dart';
import 'package:true_link/UI/ThemeColors.dart';

import '../Data&Methods/Users.dart';
import 'Profile/AllProfilePage.dart';

class PostPage extends StatelessWidget {
  final isAll;
  PostPage({super.key, this.isAll});

  List<dynamic> posts = [];

  @override
  Widget build(BuildContext context) {
    posts = isAll ? Users.allPosts : Users.tagPosts;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Text(
          'Confession Page',
          overflow: TextOverflow.ellipsis,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                ThemeColors.gradientColor1,
                ThemeColors.themeColor.withOpacity(0.01),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          const Background(),
          ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ThemeColors.gradientColor2,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(
                    color: ThemeColors.gradientColor2,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColors.themeColor.withOpacity(0.5),
                      blurRadius: 5,
                      offset: const Offset(1, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AllProfilePage(userID: posts[index]['userData']['userID']),));
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
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                posts[index]['userData']['profilepicture'],
                                fit: BoxFit.cover,
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AllProfilePage(userID: posts[index]['userData']['userID']),));
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 200,
                            child: Text(
                              posts[index]['userData']['username'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: ThemeColors.themeColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {

                          },
                          child: Container(
                            height: 30,
                            width: 60,
                            decoration: BoxDecoration(
                              color: ThemeColors.themeColor,
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Center(
                              child: Text(
                                '+ TAG',
                                style: TextStyle(
                                  color: ThemeColors.gradientColor1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      posts[index]['postData']['message'],
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: ThemeColors.themeColor,
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          boxShadow: [
            BoxShadow(
              color: ThemeColors.themeColor.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(3, 5),
            ),
          ],
        ),
        child: Center(
          child: IconButton(
            onPressed: () {

            },
            icon: Icon(
              Icons.add,
              color: ThemeColors.gradientColor1,
              size: 32,
            ),
          ),
        ),
      )
    );
  }
}
