import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Hidden Files/PrivateData.dart';
import 'Posts.dart';
import 'Requests.dart';
import 'package:http/http.dart' as http;


class Users {

  static dynamic allUserData = [];
  static dynamic currentUserData = [];
  static dynamic matchedUserData = [];

  static Future<bool> getUserData() async{
    try {
      final user = FirebaseAuth.instance.currentUser;
      if(user != null) {
        dynamic userID = await PrivateData.conn.execute("SELECT userid FROM Users WHERE userrefid = '${user.uid}'");
        bool userData = await Users.getCurrentUserData(userID[0][0]) & await Users.getMatchedUserData() & await Users.getAllUserData();
        bool requestData = await Requests.getOtherUserData() & await Requests.getMatchRequests() & await Requests.getPendingRequests();
        bool postsData = await Posts.getTagPosts();
        return userData & requestData & postsData;
      }
      return false;
    } catch(e) {
      return false;
    }
  }

  static Future<bool> getCurrentUserData(int userID) async {
    try {
      Users.currentUserData = await PrivateData.conn.execute("SELECT userID, email, username, gender, bio, profilepicture, COALESCE(matchedID, '0') AS matchedID, userrefid FROM Users WHERE userID = $userID");
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

  static Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> createUser() async {
    try {
      dynamic user = await Users.signInWithGoogle();
      if (user == null) {
        return false;
      } else {
        dynamic userID = await PrivateData.conn.execute("SELECT userid FROM Users WHERE userrefid = '${user.uid}'");
        if(userID.isEmpty) {
          final response = await http.get(Uri.parse(user.photoURL));
          final bytes = response.bodyBytes;
          final storageRef = FirebaseStorage.instance.ref().child('user_avatars/${user.uid}');
          final uploadTask = storageRef.putData(bytes);
          final snapshot = await uploadTask.whenComplete(() => null);
          String avatarURL = await snapshot.ref.getDownloadURL();
          await PrivateData.conn.execute("INSERT INTO Users (email, username, gender, profilepicture, userrefid) VALUES ('${user.email}', '${user.displayName}', true, '$avatarURL', '${user.uid}')");
        }
        await Users.getUserData();
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateUser(String username, bool gender, String bio, XFile? avatar) async {
    try {
      String profilePicture = Users.currentUserData[0][5];
      if (avatar != null) {
        final file = File(avatar.path);
        final storageRef = FirebaseStorage.instance.ref().child('user_avatars/${Users.currentUserData[0][7]}');
        final uploadTask = storageRef.putFile(file);
        final snapshot = await uploadTask.whenComplete(() => null);
        final downloadURL = await snapshot.ref.getDownloadURL();
        profilePicture = downloadURL;
      }

      await PrivateData.conn.execute("UPDATE Users SET username = '$username', gender = $gender, bio = '$bio', profilepicture = '$profilePicture' WHERE userID = ${Users.currentUserData[0][0]}");
      await Users.getUserData();
      return true;
    } catch (e) {
      print('error $e');
      return false;
    }
  }
}