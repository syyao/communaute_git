import 'dart:convert';

import 'package:communaute_git/datail_page.dart';
import 'package:communaute_git/user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PageList extends StatefulWidget {
  final String username;

  const PageList({Key key, this.username}) : super(key: key);
  @override
  _PageListState createState() => _PageListState();
}

class _PageListState extends State<PageList> {
  Future<UserModel> fetchUser(String username) async {
    final url = 'https://api.github.com/users/$username';
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

  Future<List> fetchfolowersFromUser() async {
    final url = 'https://api.github.com/users/${widget.username}/followers';
    final response = await http.get(Uri.parse(url),
        headers: {"authorization": "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"});
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List followers = [];
      followers = responseData;
      print(followers);
      return followers;
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<UserModel> futureUser;
  Future<List> futureListFollowers;
  @override
  void initState() {
    super.initState();
    futureUser = fetchUser(widget.username);
    futureListFollowers = fetchfolowersFromUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${widget.username} Followers"),
      ),
      body: Center(
        child: FutureBuilder(
          future: fetchfolowersFromUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List snap = snapshot.data;
            ConnectionState connection = snapshot.connectionState;
            if (connection == ConnectionState.waiting) {
              return Center(
                child: SpinKitFadingFour(
                  color: Theme.of(context).primaryColor,
                  size: 50.0,
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text(" error : ${snapshot.error}"));
            }

            return ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: snap.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return DetailPage(followers: snap[index]['login']);
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                                "${snapshot.data[index]["avatar_url"]}"),
                          ),
                          title: Text('${snapshot.data[index]["login"]}'),
                          subtitle: Text('${snapshot.data[index]["html_url"]}'),
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
