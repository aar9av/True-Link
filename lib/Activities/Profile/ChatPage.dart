import 'package:flutter/material.dart';
import 'package:true_link/Activities/HomePage/HomePage.dart';
import 'package:true_link/Data&Methods/Chats.dart';
import 'package:true_link/UI/ThemeInfo.dart';

import '../../Data&Methods/Users.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final focusScopeNode = FocusScopeNode();
  TextEditingController message = TextEditingController();
  bool isLoading = true;
  bool isMsgLoading = false;
  bool isBreakupLoading = false;

  @override
  initState() {
    super.initState();
    fetchChats();
  }

  Future<void> fetchChats() async {
    if(!await Chats.getChats()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Unable to load messages !!!',
          ),
          backgroundColor: ThemeInfo.gradientColor1.withOpacity(0.9),
          margin: const EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Text(
          Users.matchedUserData[0][2],
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
          Image.network(
            Users.matchedUserData[0][5],
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.75),
            colorBlendMode: BlendMode.darken,
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isLoading ?
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        ThemeInfo.loadingIcon,
                        height: 100,
                        color: ThemeInfo.themeColor,
                      ),
                    ),
                  ):
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      child: ListView.builder(
                        reverse: true,
                        itemCount: Chats.chats.length,
                        itemBuilder: (context, index) {
                          final message = Chats.chats[index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Align(
                                alignment: message[0] == Users.currentUserData[0][0] ? Alignment.centerRight : Alignment.centerLeft,
                                child: Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 200,
                                  ),
                                  margin: const EdgeInsets.all(4),
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
                                  child: Text(
                                    message[2],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
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
                                    'Are you sure you want to block the user.',
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
                                        if(!isBreakupLoading) {
                                          setState(() {
                                            isBreakupLoading = true;
                                          });
                                          if(await Chats.breakUp(Users.currentUserData[0][0], Users.currentUserData[0][6])) {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),));
                                          } else {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: const Text(
                                                  'Unable to block user!!!',
                                                ),
                                                backgroundColor: ThemeInfo.gradientColor1.withOpacity(0.9),
                                                margin: const EdgeInsets.all(10),
                                                behavior: SnackBarBehavior.floating,
                                              ),
                                            );
                                          }
                                          setState(() {
                                            isBreakupLoading = false;
                                          });
                                        }
                                      },
                                      child: const Text(
                                        'Block',
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: isBreakupLoading ?
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset(
                                  ThemeInfo.loadingIcon,
                                  height: 100,
                                  color: ThemeInfo.gradientColor1,
                                ),
                              ) :
                              Icon(
                                Icons.block,
                                color: ThemeInfo.gradientColor1,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FocusScope(
                            node: focusScopeNode,
                            child: Container(
                              height: 50,
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                color: ThemeInfo.gradientColor1,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                )
                              ),
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: message,
                                decoration: const InputDecoration(
                                  hintText: 'Write Something ...',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                ),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            focusScopeNode.unfocus();
                            if(!isMsgLoading) {
                              setState(() {
                                isMsgLoading = true;
                              });
                              if(await Chats.addChats(Users.currentUserData[0][0], Users.currentUserData[0][6], message.text)) {
                                setState(() {
                                  message.clear();
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Unable to send message !!!',
                                    ),
                                    backgroundColor: ThemeInfo.gradientColor1.withOpacity(0.9),
                                    margin: const EdgeInsets.all(10),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                              setState(() {
                                isMsgLoading = false;
                              });
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: ThemeInfo.themeColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: isMsgLoading ?
                              Image.asset(
                                ThemeInfo.loadingIcon,
                                height: 100,
                                color: ThemeInfo.gradientColor1,
                              ) :
                              Icon(
                                Icons.send,
                                color: ThemeInfo.gradientColor1,
                                size: 25,
                              ),
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
        ],
      ),
    );
  }
}
