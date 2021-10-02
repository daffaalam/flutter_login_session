import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/app_route.dart';
import '../../common/constant.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Object? args = ModalRoute.of(context)?.settings.arguments;
    String token = '';
    if (args is String) token = args;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(Constant.baseDomain),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => _signOutDialog(context),
            ),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Email\n${Constant.trueEmail}'
          '\n'
          'Token\n$token',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    await _preferences.remove(Constant.keyToken);
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoute.loginRoute,
      (Route route) => false,
    );
  }

  Widget _signOutDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Sign Out'),
      content: const Text('Are you sure you want to sign out?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => _signOut(context),
          child: const Text('YES'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('NO'),
        ),
      ],
    );
  }
}
