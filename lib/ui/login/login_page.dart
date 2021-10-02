import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/app_route.dart';
import '../../common/constant.dart';
import '../../model/req_res_login.dart';
import '../../network/api_client.dart';
import '../../widget/text_field_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerPassword;
  bool _showPassword = true;
  bool _onSend = false;

  @override
  void initState() {
    super.initState();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          children: _listTextInput(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(_onSend ? Icons.clear : Icons.send),
        onPressed: _onSend ? null : _sendLogin,
        label: Text(_onSend ? 'loading...' : 'SEND'),
      ),
    );
  }

  List<Widget> _listTextInput() {
    return <Widget>[
      TextFieldLogin(
        controller: _controllerEmail,
        labelText: 'Email',
        suffixIconData: Icons.info,
        onPressedIcon: () {
          _controllerEmail.text = Constant.trueEmail;
        },
        keyboardType: TextInputType.emailAddress,
        enable: !_onSend,
      ),
      TextFieldLogin(
        controller: _controllerPassword,
        labelText: 'Password',
        suffixIconData: _showPassword ? Icons.visibility_off : Icons.visibility,
        onPressedIcon: () {
          setState(() => _showPassword = !_showPassword);
        },
        keyboardType: TextInputType.visiblePassword,
        obscureText: _showPassword,
        enable: !_onSend,
      ),
    ];
  }

  Future<void> _sendLogin() async {
    setState(() => _onSend = true);
    ReqResLogin _reqResLogin = await ApiClient.getToken(
      email: _controllerEmail.text,
      password: _controllerPassword.text,
    );
    if (_reqResLogin.token?.isNotEmpty ?? false) {
      SharedPreferences _preferences = await SharedPreferences.getInstance();
      await _preferences.setString(Constant.keyToken, _reqResLogin.token!);
      Navigator.pushReplacementNamed(
        context,
        AppRoute.homeRoute,
        arguments: _reqResLogin.token,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _reqResLogin.error ?? 'Oops! Something went wrong...',
          ),
        ),
      );
    }
    setState(() => _onSend = false);
  }
}
