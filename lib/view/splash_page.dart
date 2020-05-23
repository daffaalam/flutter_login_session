import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/constant.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void _checkToken() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String _token = _preferences.getString(Constant.keyToken);
    Navigator.pushReplacementNamed(
      context,
      _token != null ? Constant.homeRoute : Constant.loginRoute,
      arguments: _token,
    );
  }

  @override
  void initState() {
    _checkToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
