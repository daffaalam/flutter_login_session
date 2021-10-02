import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/app_route.dart';
import '../../common/constant.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> _checkToken() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String? _token = _preferences.getString(Constant.keyToken);
    Navigator.pushReplacementNamed(
      context,
      _token != null ? AppRoute.homeRoute : AppRoute.loginRoute,
      arguments: _token,
    );
  }

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
