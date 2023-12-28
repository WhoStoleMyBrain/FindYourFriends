import 'package:find_your_friends/pages/my_home_page.dart';

import 'auth.dart';
import 'pages/login_register_page.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const MyHomePage(title: 'Flutter Demo Home Page');
        } else {
          return const LoginRegisterPage();
        }
      },
    );
  }
}
