import 'dart:async';

import 'package:find_your_friends/features/form_group/bloc/form_group_bloc.dart';
import 'package:find_your_friends/features/location/bloc/location_bloc.dart';
import 'package:find_your_friends/features/location/location_repository.dart';
import 'package:find_your_friends/features/user_location/bloc/user_location_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/authentication/bloc/authentication_bloc.dart';
import 'features/authentication/authentication_repository.dart';
import 'features/database/bloc/database_bloc.dart';
import 'features/database/database_repository.dart';
import 'features/form_validation/bloc/form_bloc.dart';
import 'my_app.dart';
import 'observers/app_bloc_observer.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = AppBlocObserver();
  // runApp(const MyApp());
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AuthenticationBloc(AuthenticationRepositoryImpl())
        ..add(AuthenticationStarted()),
    ),
    BlocProvider(
      create: (context) =>
          FormBloc(AuthenticationRepositoryImpl(), DatabaseRepositoryImpl()),
    ),
    BlocProvider(
      create: (context) => DatabaseBloc(DatabaseRepositoryImpl()),
    ),
    BlocProvider(
      create: (context) => FormGroupBloc(
          AuthenticationRepositoryImpl(), DatabaseRepositoryImpl()),
    ),
    BlocProvider(
      create: (context) => LocationBloc(LocationRepositoryImpl()),
    ),
    BlocProvider(
      create: (context) => UserLocationBloc(),
    ),
  ], child: const MyApp()));
}
