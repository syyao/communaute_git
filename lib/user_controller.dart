import 'dart:convert';
import 'dart:developer';

import 'package:communaute_git/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  List<UserModel> followers;
  String userName;
  UserModel follower;

  fetchfollowersFromUser() async {
    followers = null;
    update();
    final url = 'https://api.github.com/users/$userName/followers';
    final response = await http.get(Uri.parse(url),
        headers: {"authorization": "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"});
    log(response.body);
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      followers = [];
      responseData.forEach((element) {
        followers.add(UserModel.fromMap(element));
      });
    } else {
      followers = [];
    }
    update();
  }

  fetchUser() async {
    String followerUsername = follower.login;
    final url = 'https://api.github.com/users/$followerUsername';
    final response = await http.get(Uri.parse(url),
        headers: {"authorization": "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"});
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      follower = UserModel.fromMap(responseData);
      print(follower.toMap());
    } else {
      throw Exception('Failed to load user');
    }
    update();
  }
}
