import 'dart:convert';
import 'dart:math';
import '../Hidden Files/Routes.dart';
import 'package:http/http.dart' as http;

class Users {

  static Map<String, dynamic> currentUserData = {};
  static List<dynamic> allUserData = [];
  static Map<String, dynamic> matchedUserData = {};
  static List<dynamic> otherProfiles = [];

  static Future<bool> getAllUserData() async {
    String url = '${Routes.initialroute}/getUser';
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        allUserData = jsonDecode(response.body) as dynamic;
        String userID = (Random().nextInt(Users.allUserData.length) + 1).toString();
        for(int i=0; i<Users.allUserData.length; ++i) {
          if(Users.allUserData[i]['userID'] == userID) {
            currentUserData = Users.allUserData[i];
            break;
          }
        }
        for(int i=0; i<Users.allUserData.length; ++i) {
          if(Users.allUserData[i]['userID'] == Users.currentUserData['matchedID']) {
            matchedUserData = Users.allUserData[i];
            break;
          }
        }
        for(int i=0; i<Users.allUserData.length; ++i) {
          if(Users.allUserData[i]['gender'] != Users.currentUserData['gender'] && Users.allUserData[i]['userID'] != Users.matchedUserData['userID']) {
            otherProfiles.add(Users.allUserData[i]);
          }
        }
        otherProfiles.shuffle();
        return true;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch(e) {
      print(e);
      return false;
    }
  }
}