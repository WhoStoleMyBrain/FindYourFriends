import 'package:find_your_friends/features/database/bloc/database_bloc.dart';
import 'package:find_your_friends/features/database/database_repository.dart';
import 'package:find_your_friends/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/authentication/bloc/authentication_bloc.dart';
import '../models/group_model.dart';
import 'welcome_view.dart';

class GroupOverviewView extends StatelessWidget {
  GroupOverviewView({super.key});

  final DatabaseRepository _databaseRepository = DatabaseRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
      if (state is AuthenticationFailure) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const WelcomeView()),
            (Route<dynamic> route) => false);
      }
    }, buildWhen: ((previous, current) {
      if (current is AuthenticationFailure) {
        return false;
      }
      return true;
    }), builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () async {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationSignedOut());
                })
          ],
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.blue),
          title: const Text("Group Overview"),
        ),
        body: StreamBuilder(
          stream: _databaseRepository.retrieveGroupData(),
          builder: (context, AsyncSnapshot<List<GroupModel>> snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data![index].groupName!),
                    subtitle: Text(snapshot.data![index].description!),
                    trailing: Text(snapshot.data![index].creator!),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const HomeView(),
                ),
                (route) => false);
          },
          child: const Text('Home'),
        ),
      );
    });
  }
}
