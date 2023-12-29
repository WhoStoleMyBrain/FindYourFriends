// import 'package:find_your_friends/pages/login_register_page.dart';
// import 'package:find_your_friends/pages/my_home_page.dart';
import 'package:find_your_friends/views/home_view.dart';
import 'package:find_your_friends/views/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/bloc/authentication_bloc.dart';
import 'utils/constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BlocNavigate(),
    );
  }
}

class BlocNavigate extends StatelessWidget {
  const BlocNavigate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: ((context, state) {
      if (state is AuthenticationSuccess) {
        // return const MyHomePage(title: Constants.title);
        return const HomeView();
      } else {
        // return const LoginRegisterPage();
        return const WelcomeView();
      }
    }));
  }
}
