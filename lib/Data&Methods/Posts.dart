import 'package:true_link/Hidden%20Files/PrivateData.dart';

import 'Users.dart';

class Posts {

  static dynamic allPosts = [];
  static dynamic tagPosts = [];

  static Future<bool> getTagPosts () async {
    try {
      Posts.tagPosts = await PrivateData.conn.execute("SELECT * FROM (SELECT DISTINCT p.*, u.* FROM Tags t JOIN Posts p ON t.messageID = p.messageID JOIN Users u ON p.userID = u.userID WHERE t.userID = ${Users.currentUserData[0][0]}) AS distinct_records ORDER BY distinct_records.timestamp DESC");
      return true;
    } catch(e) {
      return false;
    }
  }

  static Future<bool> getAllPosts () async {
    try {
      Posts.allPosts = await PrivateData.conn.execute("SELECT * FROM Posts p JOIN Users u ON p.userID = u.userID ORDER BY timestamp DESC");
      return true;
    } catch(e) {
      return false;
    }
  }

  static Future<bool> addPost(String message) async {
    try {
      await PrivateData.conn.execute("INSERT INTO Posts (userID, message) VALUES (${Users.currentUserData[0][0]}, '$message')");
      return await Posts.getAllPosts();
    } catch (e) {
      return false;
    }
  }

  static Future<bool> addTag(int userID, int messageID) async {
    try {
      await PrivateData.conn.execute("INSERT INTO Tags (userID, messageID, taggerID) VALUES ($userID, $messageID, ${Users.currentUserData[0][0]})");
      return await Posts.getTagPosts();
    } catch (e) {
      return false;
    }
  }
}