import '../Hidden Files/PrivateData.dart';
import 'Posts.dart';
import 'Requests.dart';

class Users {

  static dynamic allUserData = [];
  static dynamic currentUserData = [];
  static dynamic matchedUserData = [];

  static Future<bool> getUserData(int randomUser) async{
    bool userData = await Users.getCurrentUserData(randomUser) & await Users.getMatchedUserData() & await Users.getAllUserData();
    bool requestData = await Requests.getOtherUserData() & await Requests.getMatchRequests() & await Requests.getPendingRequests();
    bool postsData = await Posts.getTagPosts();

    return userData & requestData & postsData;
  }

  static Future<bool> getCurrentUserData(int randomUser) async {
    try {
      Users.currentUserData = await PrivateData.conn.execute("SELECT userID, email, username, gender, bio, profilepicture, COALESCE(matchedID, '0') AS matchedID FROM Users WHERE userID = $randomUser");
      return true;
    } catch(e) {
      return false;
    }
  }

  static Future<bool> getMatchedUserData() async {
    try {
      Users.matchedUserData = await PrivateData.conn.execute("SELECT * FROM Users WHERE userID = ${Users.currentUserData[0][6]}");
      return true;
    } catch(e) {
      return false;
    }
  }

  static Future<bool> getAllUserData() async {
    try {
      Users.allUserData = await PrivateData.conn.execute("SELECT * FROM Users");
      return true;
    } catch(e) {
      return false;
    }
  }

  static Future<bool> createUser(String email, String username, bool gender, String userRefID) async {
    try {
      await PrivateData.conn.execute("INSERT INTO Users (email, username, gender, userrefid) VALUES ('$email', '$username', $gender, '$userRefID')");
      dynamic userID = await PrivateData.conn.execute("SELECT userid FROM Users WHERE email = '$email'");
      await Users.getUserData(userID[0][0]);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateUser(String username, bool gender, String bio) async {
    try {
      await PrivateData.conn.execute("UPDATE Users SET username = '$username', gender = $gender, bio = '$bio' WHERE userID = ${currentUserData[0][0]}");
      await Users.getUserData(Users.currentUserData[0][0]);
      return true;
    } catch (e) {
      return false;
    }
  }

}