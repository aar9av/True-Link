import 'dart:async';

import 'package:true_link/Hidden%20Files/PrivateData.dart';
import 'package:firebase_database/firebase_database.dart';

import 'Users.dart';

class Chats {

  static dynamic chats = [];
  static bool isBlock = false;

  static Future<bool> getMessages() async {
    try {
      DatabaseReference chatRef;
      chatRef = FirebaseDatabase.instance.ref('messages/${Users.currentUserData[0][7]}/${Users.matchedUserData[0][7]}');
      final snapshot1 = await chatRef.get();
      chatRef = FirebaseDatabase.instance.ref('messages/${Users.matchedUserData[0][7]}/${Users.currentUserData[0][7]}');
      final snapshot2 = await chatRef.get();
      Chats.chats.clear();
      if (snapshot1.exists) {
        final data = snapshot1.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          Chats.chats.add({
            'senderId': Users.currentUserData[0][0],
            'message': value['message'],
            'timestamp': value['timestamp'],
          });
        });
      }
      if (snapshot2.exists) {
        final data = snapshot2.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          Chats.chats.add({
            'senderId': Users.matchedUserData[0][0],
            'message': value['message'],
            'timestamp': value['timestamp'],
          });
        });
      }
      Chats.chats.sort((a, b) => (b['timestamp'] as int).compareTo(a['timestamp'] as int));
      return true;
    } catch(e) {
      return false;
    }
  }

  static Future<bool> sendMessage(String message) async {
    try {
      DatabaseReference chatRef = FirebaseDatabase.instance.ref('messages/${Users.currentUserData[0][7]}/${Users.matchedUserData[0][7]}');
      await chatRef.push().set({
        'message': message,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
      await getMessages();
      return true;
    } catch(e) {
      return false;
    }
  }

  static Future<bool> breakUp(int userID, int matchedID) async {
    try {
      await PrivateData.conn.execute("BEGIN");
      await PrivateData.conn.execute("UPDATE Users SET matchedID = null WHERE userID = $matchedID OR userID = $userID");
      await PrivateData.conn.execute("INSERT INTO History (userID, matchedID) VALUES ($matchedID, $userID)");
      await PrivateData.conn.execute("COMMIT");
      return true;
    } catch (e) {
      await PrivateData.conn.execute("ROLLBACK");
      return false;
    }
  }
}