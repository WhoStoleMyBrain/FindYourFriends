import 'package:find_your_friends/features/authentication/bloc/authentication_bloc.dart';
import 'package:find_your_friends/views/welcome_view.dart';
import 'package:find_your_friends/widgets/standard_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/radial_menu.dart';

class StandardPage extends StatelessWidget {
  const StandardPage({super.key, required this.widget, required this.title});
  final Widget widget;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationFailure) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const WelcomeView()),
              (Route<dynamic> route) => false);
        }
      },
      child: Scaffold(
        appBar: StandardAppBar(title: title),
        body: widget,
        floatingActionButton: const RadialMenu(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
