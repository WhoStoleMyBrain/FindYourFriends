import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/authentication/bloc/authentication_bloc.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StandardAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: <Widget>[
        IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () async {
              context.read<AuthenticationBloc>().add(AuthenticationSignedOut());
            })
      ],
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: Colors.blue),
      title: Text(title),
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}
