import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/constant.dart';
import '../model/req_res_login.dart';
import '../network/api_client.dart';
import '../widget/text_field_login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> _globalKey;
  TextEditingController _controllerEmail;
  TextEditingController _controllerPassword;
  bool _showPassword = true;
  bool _sending = false;

  void _sendLogin() async {
    setState(() {
      _sending = true;
    });
    ReqResLogin _reqResLogin = await ApiClient.getToken(
      email: _controllerEmail.text,
      password: _controllerPassword.text,
    );
    if (_reqResLogin.token != null) {
      SharedPreferences _preferences = await SharedPreferences.getInstance();
      _preferences.setString(Constant.keyToken, _reqResLogin.token);
      Navigator.pushReplacementNamed(
        context,
        Constant.homeRoute,
        arguments: _reqResLogin.token,
      );
    } else {
      _globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text(_reqResLogin.error),
        ),
      );
    }
    setState(() {
      _sending = false;
    });
  }

  @override
  void initState() {
    _globalKey = GlobalKey<ScaffoldState>();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: SafeArea(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(8.0),
          children: _listTextInput(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(_sending ? Icons.clear : Icons.send),
        onPressed: _sending ? null : _sendLogin,
        label: Text(_sending ? "loading..." : "SEND"),
      ),
    );
  }

  List<Widget> _listTextInput() {
    return <Widget>[
      TextFieldLogin(
        controller: _controllerEmail,
        labelText: "Email",
        suffixIconData: Icons.info,
        onPressedIcon: () {
          setState(() {
            _controllerEmail.text = Constant.trueEmail;
          });
        },
        keyboardType: TextInputType.emailAddress,
        enable: !_sending,
      ),
      TextFieldLogin(
        controller: _controllerPassword,
        labelText: "Password",
        suffixIconData: _showPassword ? Icons.visibility_off : Icons.visibility,
        onPressedIcon: () {
          setState(() {
            _showPassword = !_showPassword;
          });
        },
        keyboardType: TextInputType.visiblePassword,
        obscureText: _showPassword,
        enable: !_sending,
      ),
    ];
  }
}
