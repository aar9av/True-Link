import 'dart:convert';
import 'dart:math';

import '../Hidden Files/Routes.dart';
import 'package:http/http.dart' as http;

class Users {

  static List<dynamic> allUserData = [];
  static Map<String, dynamic> currentUserData = {};
  static Map<String, dynamic> matchedUserData = {};
  static List<dynamic> otherProfiles = [];

  static List<dynamic> matchRequests = [];
  static List<dynamic> pendingRequests = [];
  static List<dynamic> userHistory = [];

  static List<dynamic> chats = [];

  static List<dynamic> allPosts = [];
  static List<dynamic> tagPosts = [];

  static Future<bool> getUserData() async{
    if(await getAllUsersData()) {
      extractUserData();
      extractRequests(await getAllRequests());
      extractHistory(await getAllHistory());
      extractChats(await getAllChats());
      extractPosts(await getAllPosts());
      extractTags(await getAllTags());
      return true;
    }
    return false;
  }

  static Future<bool> getAllUsersData() async{
    String url = '${Routes.initialroute}/getUsers';
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        Users.allUserData = jsonDecode(response.body) as dynamic;
        return true;
      } else {
        return false;
      }
    } catch(e) {
      return false;
    }
  }

  static void extractUserData() {
    pickRandomUser();
    extractMatchedUserData();
    extractOtherProfiles();
  }

  static void pickRandomUser() {
    String userID = (Random().nextInt(Users.allUserData.length) + 1).toString();
    for(int i=0; i<Users.allUserData.length; ++i) {
      if(Users.allUserData[i]['userID'] == userID) {
        Users.currentUserData = Users.allUserData[i];
        break;
      }
    }
  }

  static void extractMatchedUserData() {
    for(int i=0; i<Users.allUserData.length; ++i) {
      if(Users.allUserData[i]['userID'] == Users.currentUserData['matchedID']) {
        Users.matchedUserData = Users.allUserData[i];
        break;
      }
    }
  }

  static void extractOtherProfiles() {
    Users.otherProfiles.clear();
    for(int i=0; i<Users.allUserData.length; ++i) {
      if(Users.allUserData[i]['gender'] != Users.currentUserData['gender'] && Users.allUserData[i]['userID'] != Users.matchedUserData['userID']) {
        Users.otherProfiles.add(Users.allUserData[i]);
      }
    }
    otherProfiles.shuffle();
  }

  static Future<List<dynamic>> getAllRequests() async{
    String url = '${Routes.initialroute}/getRequests';
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        return jsonDecode(response.body) as dynamic;
      } else {
        return [];
      }
    } catch(e) {
      return [];
    }
  }

  static void extractRequests(List<dynamic> allRequests) {
    extractMatchRequests(allRequests);
    extractPendingRequests(allRequests);
  }

  static void extractPendingRequests(List<dynamic> allRequests) {
    for(int i=0; i<allRequests.length; ++i) {
      for(int j=0; j<Users.allUserData.length; ++j) {
        if(allRequests[i]['senderID'] == Users.currentUserData['userID'] && allRequests[i]['receiverID'] == Users.allUserData[j]['userID']) {
          Users.pendingRequests.add(Users.allUserData[j]);
        }
      }
    }
  }

  static void extractMatchRequests(List<dynamic> allRequests) {
    for(int i=0; i<allRequests.length; ++i) {
      for(int j=0; j<Users.allUserData.length; ++j) {
        if(allRequests[i]['receiverID'] == Users.currentUserData['userID'] && allRequests[i]['senderID'] == Users.allUserData[j]['userID']) {
          Users.matchRequests.add(Users.allUserData[j]);
        }
      }
    }
  }

  static Future<List<dynamic>> getAllHistory() async{
    String url = '${Routes.initialroute}/getHistory';
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        return jsonDecode(response.body) as dynamic;
      } else {
        return [];
      }
    } catch(e) {
      return [];
    }
  }

  static void extractHistory(List<dynamic> allHistory) {
    for(int i=0; i<allHistory.length; ++i) {
      if(allHistory[i]['userID'] == Users.currentUserData['userID']) {
        for(int j=0; j<Users.allUserData.length; ++j) {
          if(allHistory[i]['matchedID'] == Users.allUserData[j]['userID']) {
            Users.userHistory.add(Users.allUserData[j]);
          }
        }
      } else if(allHistory[i]['matchedID'] == Users.currentUserData['userID']) {
        for(int j=0; j<Users.allUserData.length; ++j) {
          if(allHistory[i]['userID'] == Users.allUserData[j]['userID']) {
            Users.userHistory.add(Users.allUserData[j]);
          }
        }
      }
    }
  }

  static Future<List<dynamic>> getAllChats() async{
    String url = '${Routes.initialroute}/getChats';
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        return jsonDecode(response.body) as dynamic;
      } else {
        return [];
      }
    } catch(e) {
      return [];
    }
  }

  static void extractChats(List<dynamic> allChats) {
    for(int i=0; i<allChats.length; ++i) {
      if(allChats[i]['senderID'] == Users.currentUserData['userID'] || allChats[i]['senderID'] == Users.matchedUserData['userID']) {
        Users.chats.add(allChats[i]);
      }
    }
  }

  static Future<List<dynamic>> getAllPosts() async{
    String url = '${Routes.initialroute}/getPosts';
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        return jsonDecode(response.body) as dynamic;
      } else {
        return [];
      }
    } catch(e) {
      return [];
    }
  }

  static void extractPosts(List<dynamic> allPosts) {
    for(int i=0; i<allPosts.length; ++i) {
      for(int j=0; j<allUserData.length; ++j) {
        if(allPosts[i]['userID'] == allUserData[j]['userID']) {
          Users.allPosts.add({'postData': allPosts[i], 'userData': Users.allUserData[j]});
          break;
        }
      }
    }
  }

  static Future<List<dynamic>> getAllTags() async{
    String url = '${Routes.initialroute}/getTags';
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        return jsonDecode(response.body) as dynamic;
      } else {
        return [];
      }
    } catch(e) {
      return [];
    }
  }

  static void extractTags(List<dynamic> allTags) {
    for(int i=0; i<allTags.length; ++i) {
      for(int j=0; j<Users.allUserData.length; ++j) {
        if(allTags[i]['userID'] == Users.currentUserData['userID']) {
          for(int k=0; k<Users.allPosts.length; ++k) {
            if(allTags[i]['messageID'] == Users.allPosts[k]['postData']['messageID']) {
              Users.tagPosts.add(allPosts[k]);
              break;
            }
          }
          break;
        }
      }
    }
  }

}