import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/constant.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sign Out"),
          content: Text("Are you sure you want to sign out?"),
          actions: <Widget>[
            FlatButton(
              onPressed: _signOut,
              child: Text("YES"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("NO"),
            ),
          ],
        );
      },
    );
  }

  void _signOut() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.clear();
    Navigator.pushNamedAndRemoveUntil(
      context,
      Constant.loginRoute,
      (Route route) {
        return false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String _token = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(Constant.trueEmail),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _showAlert,
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.0),
        child: Text(
          "Your Token:\n$_token",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
