import '../Hidden Files/PrivateData.dart';
import 'Chats.dart';
import 'Users.dart';

class Requests {

  static dynamic otherProfiles = [];
  static dynamic matchRequests = [];
  static dynamic pendingRequests = [];
  static dynamic userHistory = [];

  static Future<bool> getOtherUserData() async {
    try {
      Requests.otherProfiles = await PrivateData.conn.execute("SELECT userID, email, username, gender, bio, profilepicture, COALESCE(matchedID, '0') AS matchedID FROM Users WHERE userID != ${Users.currentUserData[0][6]} AND gender != ${Users.currentUserData[0][3]} AND userID NOT IN (SELECT receiverID FROM Requests WHERE senderID = ${Users.currentUserData[0][0]} UNION SELECT senderID FROM Requests WHERE receiverID = ${Users.currentUserData[0][0]} UNION SELECT matchedID FROM History WHERE userID = ${Users.currentUserData[0][0]} UNION SELECT userID FROM History WHERE matchedID = ${Users.currentUserData[0][0]})");
      return true;
    } catch(e) {
      return false;
    }
  }

  static Future<bool> getMatchRequests() async {
    try {
      Requests.matchRequests = await PrivateData.conn.execute("SELECT u.userID, u.email, u.username, u.gender, u.bio, u.profilepicture, COALESCE(u.matchedID, '0') AS matchedID FROM Users u, Requests r WHERE r.receiverID = ${Users.currentUserData[0][0]} AND u.userID = r.senderID ORDER BY r.timestamp DESC");
      return true;
    } catch(e) {
      return false;
    }
  }

  static Future<bool> getPendingRequests() async {
    try {
      Requests.pendingRequests = await PrivateData.conn.execute("SELECT u.userID, u.email, u.username, u.gender, u.bio, u.profilepicture, COALESCE(u.matchedID, '0') AS matchedID FROM Users u, Requests r WHERE r.senderID = ${Users.currentUserData[0][0]} AND u.userID = r.receiverID ORDER BY r.timestamp DESC");
      return true;
    } catch(e) {
      return false;
    }
  }

  static Future<bool> getUserHistory() async {
    try {
      Requests.userHistory = await PrivateData.conn.execute("SELECT u.userID, u.email, u.username, u.gender, u.bio, u.profilepicture, COALESCE(u.matchedID, '0') AS matchedID, h.timestamp FROM Users u JOIN (SELECT matchedID AS userID, timestamp FROM History WHERE userID = ${Users.currentUserData[0][0]} UNION SELECT userID, timestamp FROM History WHERE matchedID = ${Users.currentUserData[0][0]}) h ON u.userID = h.userID ORDER BY h.timestamp DESC");
      return true;
    } catch(e) {
      return false;
    }
  }

  static Future<bool> addRequest(int receiverID) async {
    try {
      await PrivateData.conn.execute("INSERT INTO Requests (senderID, receiverID) VALUES (${Users.currentUserData[0][0]}, $receiverID)");
      await PrivateData.conn.execute("DELETE FROM History WHERE (userID = ${Users.currentUserData[0][0]} AND matchedID = $receiverID) OR (userID = $receiverID AND matchedID = ${Users.currentUserData[0][0]})");
      await Requests.getPendingRequests();
      await Requests.getOtherUserData();
      await Requests.getUserHistory();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> cancelRequest(int receiverID) async {
    try {
      await PrivateData.conn.execute("DELETE FROM Requests WHERE senderID = ${Users.currentUserData[0][0]} AND receiverID = $receiverID");
      await Requests.getPendingRequests();
      await Requests.getOtherUserData();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> acceptRequest(dynamic sender) async {
    try {
      await Chats.breakUp(sender[0], sender[6]);
      await Chats.breakUp(Users.currentUserData[0][0], Users.currentUserData[0][6]);
      await PrivateData.conn.execute("UPDATE Users SET matchedID = ${sender[0]} WHERE userID = ${Users.currentUserData[0][0]}");
      await PrivateData.conn.execute("UPDATE Users SET matchedID = ${Users.currentUserData[0][0]} WHERE userID = ${sender[0]}");
      await PrivateData.conn.execute("DELETE FROM History WHERE (userID = ${Users.currentUserData[0][0]} AND matchedID = ${sender[0]}) OR (userID = ${sender[0]} AND matchedID = ${Users.currentUserData[0][0]})");
      await PrivateData.conn.execute("DELETE FROM Requests WHERE senderID = ${sender[0]} AND receiverID = ${Users.currentUserData[0][0]}");
      await Users.getMatchedUserData();
      await Requests.getOtherUserData();
      await Requests.getMatchRequests();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}