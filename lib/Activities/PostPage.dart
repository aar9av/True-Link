import 'dart:math';

import 'package:flutter/material.dart';

import '../Data&Methods/Posts.dart';
import '../Data&Methods/Users.dart';
import '../Initial Files/Background.dart';
import '../Initial Files/ThemeInfo.dart';
import 'AllProfilePage.dart';

class PostPage extends StatefulWidget {
  final isAll;
  const PostPage({super.key, this.isAll});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<dynamic> posts = [];
  bool isLoading = true;
  bool isAddPost = false;
  TextEditingController message = TextEditingController();
  bool isAdding = false;
  bool isAddTag = false;
  int postDataForTag = 0;
  TextEditingController findValue = TextEditingController();
  List<dynamic> searchedUser = [];
  int taggedUser = 0;
  bool isSearch = false;

  @override
  initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    if(widget.isAll && Posts.allPosts.length == 0) {
      await Posts.getAllPosts();
    }
    posts = widget.isAll ? Posts.allPosts : Posts.tagPosts;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    posts = widget.isAll ? Posts.allPosts : Posts.tagPosts;
    final focusScopeNode = FocusScopeNode();

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
                ThemeInfo.gradientColor1,
                ThemeInfo.themeColor.withOpacity(0.01),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          const Background(),
          isLoading ?
          Center(
            child: Image.asset(
              ThemeInfo.loadingIcon,
              height: 100,
              color: ThemeInfo.themeColor,
            ),
          ) :
          ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ThemeInfo.gradientColor2,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(
                    color: ThemeInfo.gradientColor2,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeInfo.themeColor.withOpacity(0.5),
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
                            if(!widget.isAll) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    AllProfilePage(
                                        userID: posts[index][2]),));
                            }
                          },
                          child: widget.isAll ?
                          const SizedBox(
                            height: 0,
                            width: 0,
                          ) :
                          Container(
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
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                posts[index][9],
                                fit: BoxFit.cover,
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if(!widget.isAll) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    AllProfilePage(
                                        userID: posts[index][2]),));
                            }
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 200,
                            child: Text(
                              widget.isAll ? (posts[index][7] ? 'Mr. Random' : 'Miss. Random') : posts[index][6],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: ThemeInfo.themeColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              postDataForTag = posts[index][0];
                              isAddTag = true;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 60,
                            decoration: BoxDecoration(
                              color: ThemeInfo.themeColor,
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Center(
                              child: Text(
                                '+ TAG',
                                style: TextStyle(
                                  color: ThemeInfo.gradientColor1,
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
                      posts[index][1],
                      textAlign: TextAlign.justify,
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
          isAddPost ?
          Center(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: ThemeInfo.gradientColor1.withOpacity(0.9),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(40),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ThemeInfo.gradientColor2,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color: ThemeInfo.themeColor.withOpacity(0.5),
                        blurRadius: 7,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Write a confession',
                            style: TextStyle(
                              color: ThemeInfo.themeColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          color: ThemeInfo.gradientColor1,
                          height: 160,
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            controller: message,
                            maxLines: 10,
                            decoration: InputDecoration(
                              hintText: 'Confess something to someone special...',
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
                                  color: ThemeInfo.themeColor,
                                ),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 60,),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              isAdding = true;
                            });
                            if(await Posts.addPost(message.text)) {
                              setState(() {
                                isAddPost = false;
                                message.text = "";
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'Confession added successfully !!!',
                                  ),
                                  backgroundColor: ThemeInfo.gradientColor1.withOpacity(0.9),
                                  margin: const EdgeInsets.all(10),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'Unable to post your confession !!!',
                                  ),
                                  backgroundColor: ThemeInfo.gradientColor1.withOpacity(0.9),
                                  margin: const EdgeInsets.all(10),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                            setState(() {
                              isAdding = false;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
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
                            child: isAdding ?
                            Center(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  ThemeInfo.loadingIcon,
                                  height: 100,
                                  color: ThemeInfo.gradientColor1,
                                ),
                              ),
                            ) :
                            const Center(
                              child: Text(
                                'Confess',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ) :
          const SizedBox(),
          isAddTag ?
          Center(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: ThemeInfo.gradientColor1.withOpacity(0.9),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(40),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ThemeInfo.gradientColor2,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color: ThemeInfo.themeColor.withOpacity(0.5),
                        blurRadius: 7,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Tag someone',
                            style: TextStyle(
                              color: ThemeInfo.themeColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
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
                          child: FocusScope(
                            node: focusScopeNode,
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
                                    setState(() {
                                      findValue.text = '@${searchedUser[index][2]}';
                                      taggedUser = searchedUser[index][0];
                                      searchedUser.clear();
                                    });
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
                        const SizedBox(height: 60,),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              isAdding = true;
                            });
                            if(await Posts.addTag(taggedUser, postDataForTag)) {
                              setState(() {
                                isAddTag = false;
                                findValue.text = "";
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'User tagged successfully !!!',
                                  ),
                                  backgroundColor: ThemeInfo.gradientColor1.withOpacity(0.9),
                                  margin: const EdgeInsets.all(10),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'Unable to tag !!!',
                                  ),
                                  backgroundColor: ThemeInfo.gradientColor1.withOpacity(0.9),
                                  margin: const EdgeInsets.all(10),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                            setState(() {
                              isAdding = false;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
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
                            child: isAdding ?
                            Center(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  ThemeInfo.loadingIcon,
                                  height: 100,
                                  color: ThemeInfo.gradientColor1,
                                ),
                              ),
                            ) :
                            const Center(
                              child: Text(
                                'Tag Someone',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ) :
          const SizedBox(),
        ],
      ),
      floatingActionButton: widget.isAll ?
      Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: ThemeInfo.themeColor,
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          boxShadow: [
            BoxShadow(
              color: ThemeInfo.themeColor.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(3, 5),
            ),
          ],
        ),
        child: Center(
          child: IconButton(
            onPressed: () {
              setState(() {
                isAddPost = !isAddPost;
              });
            },
            icon: Icon(
              isAddPost ? Icons.arrow_back : Icons.add,
              color: ThemeInfo.gradientColor1,
              size: 32,
            ),
          ),
        ),
      ) : null,
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
