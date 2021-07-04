import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:communaute_git/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DetailPage extends StatefulWidget {
  final String followers;

  const DetailPage({Key key, this.followers}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<UserModel> fetchUser() async {
    final url = 'https://api.github.com/users/${widget.followers}';
    final response = await http.get(Uri.parse(url),
        headers: {"authorization": "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"});
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      UserModel user;

      user = UserModel.fromMap(responseData);
      print(user.toMap());
      return user;
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<UserModel> futurefollower;

  @override
  void initState() {
    super.initState();
    futurefollower = fetchUser();
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
      body: FutureBuilder<UserModel>(
        future: futurefollower,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(snapshot.data.avatarUrl),
                      ),
                      SizedBox(width: 20),
                      Flexible(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data.login ?? "",
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: Text(
                                      snapshot.data.name ?? "",
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: Text(
                                      snapshot.data.email ?? "",
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: Text(
                                      snapshot.data.following.toString() ?? "",
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: Text(
                                      snapshot.data.followers.toString() ?? "",
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: Text(
                                      snapshot.data.publicRepos.toString() ??
                                          "",
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: Text(
                                      snapshot.data.htmlUrl ?? "",
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: Text(
                                      snapshot.data.bio ?? "",
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
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return Center(
            child: SpinKitFadingFour(
              color: Theme.of(context).primaryColor,
              size: 50.0,
            ),
          );
        },
      ),
    );
  }
}
