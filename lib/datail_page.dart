import 'package:communaute_git/user_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:communaute_git/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  UserController controller = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    controller.fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: GetBuilder(
        init: controller,
        builder: (UserController c) {
          UserModel follower = c.follower;
          if (follower == null) {
            return Center(
              child: SpinKitFadingFour(
                color: Theme.of(context).primaryColor,
                size: 50.0,
              ),
            );
          }
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(follower.avatarUrl),
                    ),
                    SizedBox(width: 20),
                    Flexible(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          follower.login,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Details followers",
                        style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Text(
                                    "Nom:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: Text(
                                    follower.name ?? "",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ))
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email :",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: Text(
                                    follower.email ?? "",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ))
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Followings:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: Text(
                                    follower.following.toString() ?? "",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ))
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Followers:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: Text(
                                    follower.followers.toString() ?? "",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ))
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Public repository:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: Text(
                                    follower.publicRepos.toString() ?? "",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ))
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Html Url:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: Text(
                                    follower.htmlUrl ?? "",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ))
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Biographie:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: Text(
                                    follower.bio ?? "",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
