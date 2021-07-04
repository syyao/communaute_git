import 'package:communaute_git/pageList.dart';
import 'package:flutter/material.dart';

class FeildPage extends StatefulWidget {
  @override
  _FeildPageState createState() => _FeildPageState();
}

class _FeildPageState extends State<FeildPage> {
  TextEditingController userNameController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  void search() {
    if (_globalKey.currentState.validate()) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PageList(
          username: userNameController.text,
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 200),
                Image(
                  image: AssetImage('images/logo.png'),
                  fit: BoxFit.cover,
                  height: 100,
                ),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: userNameController,
                    // obscureText: obscurText,
                    // keyboardType: typeKeyBoard,
                    validator: (value) => value.trim().isEmpty
                        ? 'veuiller renseigner votre pseudo'
                        : null,
                    // onChanged: onChanged,

                    decoration: InputDecoration(
                      // suffixIcon: iconSuffix,
                      contentPadding: EdgeInsets.all(5),
                      errorStyle: TextStyle(
                        height: 0.5,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0.5),
                      ),
                      labelText: "Username gitHub",
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0.5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 0.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 0.5),
                      ),
                      filled: true,
                      fillColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      hintStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    return search();
                  },
                  child: Card(
                    color: Color.fromRGBO(36, 41, 46, 1),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Rechercher',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
