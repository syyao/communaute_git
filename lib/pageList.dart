import 'package:communaute_git/datail_page.dart';
import 'package:communaute_git/user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'user_controller.dart';

class PageList extends StatefulWidget {
  @override
  _PageListState createState() => _PageListState();
}

class _PageListState extends State<PageList> {
  Future<void> _showMyDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  UserController controller = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    controller.fetchfollowersFromUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${controller.userName} Followers"),
      ),
      body: Center(
        child: GetBuilder(
          init: controller,
          builder: (UserController c) {
            List<UserModel> followers = c.followers;

            if (followers == null) {
              return Center(
                child: SpinKitFadingFour(
                  color: Theme.of(context).primaryColor,
                  size: 50.0,
                ),
              );
            }
            if (followers.isEmpty) {
              return Center(child: Text("Aucun follower"));
            }

            return ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: followers.length,
                itemBuilder: (context, index) {
                  UserModel follower = followers[index];
                  return InkWell(
                    onTap: () {
                      controller.follower = follower;
                      Get.to(DetailPage());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(follower.avatarUrl),
                          ),
                          title: Text(follower.login),
                          subtitle: Text(follower.htmlUrl),
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
