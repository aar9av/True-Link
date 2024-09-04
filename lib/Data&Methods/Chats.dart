import 'package:true_link/Data&Methods/Requests.dart';
import 'package:true_link/Hidden%20Files/PrivateData.dart';

import 'Users.dart';

class Chats {

  static dynamic chats = [];

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
      await PrivateData.conn.execute("UPDATE Users SET matchedID = null WHERE userID = $matchedID OR userID = $userID");
      if(matchedID != 0) {
        await PrivateData.conn.execute("INSERT INTO History (userID, matchedID) VALUES ($matchedID, $userID)");
      }
      await Users.getCurrentUserData(Users.currentUserData[0][0]);
      await Requests.getUserHistory();
      return true;
    } catch (e) {
      return false;
    }
  }
}