import 'package:true_link/Hidden%20Files/PrivateData.dart';

import 'Users.dart';

class Chats {

  static dynamic chats = [];
  static bool isBlock = false;

  static Future<bool> getChats () async {
    try {
      Chats.chats = await PrivateData.conn.execute("SELECT * FROM Chats WHERE(senderID = ${Users.currentUserData[0][0]} AND receiverID = ${Users.currentUserData[0][6]}) OR (senderID = ${Users.currentUserData[0][6]} AND receiverID = ${Users.currentUserData[0][0]}) ORDER BY timestamp DESC");
      return true;
    } catch(e) {
      return false;
    }
  }

  static Future<bool> addChats (int senderID, int receiverID, String message) async {
    try {
      Chats.chats = await PrivateData.conn.execute("INSERT INTO Chats (senderID, receiverID, message) VALUES ($senderID, $receiverID, '$message')");
      return await Chats.getChats();
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