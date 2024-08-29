import 'package:flutter/material.dart';
import 'package:true_link/UI/ThemeColors.dart';

import '../Data&Methods/Users.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController message = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Text(
          Users.matchedUserData['username'],
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
          Image.network(
            Users.matchedUserData['profilepicture'],
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
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      child: ListView.builder(
                        reverse: true,
                        itemCount: Users.chats.length,
                        itemBuilder: (context, index) {
                          final message = Users.chats[index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Align(
                                alignment: message['senderID'] == Users.currentUserData['userID'] ? Alignment.centerRight : Alignment.centerLeft,
                                child: Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 200,
                                  ),
                                  margin: const EdgeInsets.all(4),
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
                                  child: Text(
                                    message['message'],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            color: ThemeColors.gradientColor1,
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLoading = true;
                            Users.chats.insert(0, {"senderID": Users.currentUserData['userID'], "message": message.text});
                            message.clear();
                            isLoading = false;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: ThemeColors.themeColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: isLoading ?
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: ThemeColors.gradientColor1,
                                strokeWidth: 2,
                              ),
                            ):
                            Icon(
                              Icons.send,
                              color: ThemeColors.gradientColor1,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
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
