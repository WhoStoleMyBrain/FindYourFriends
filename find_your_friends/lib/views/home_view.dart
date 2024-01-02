import 'package:find_your_friends/features/authentication/bloc/authentication_bloc.dart';
import 'package:find_your_friends/features/database/bloc/database_bloc.dart';
import 'package:find_your_friends/views/group_creation_view.dart';
import 'package:find_your_friends/views/group_overview_view.dart';
import 'package:find_your_friends/views/welcome_view.dart';
import 'package:find_your_friends/widgets/user_location_poc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
          title: Text((state as AuthenticationSuccess).displayName!),
        ),
        body: BlocBuilder<DatabaseBloc, DatabaseState>(
          builder: (context, state) {
            String? displayName = (context.read<AuthenticationBloc>().state
                    as AuthenticationSuccess)
                .displayName;
            if (state is DatabaseUserFetchedSuccess &&
                displayName !=
                    (context.read<DatabaseBloc>().state
                            as DatabaseUserFetchedSuccess)
                        .displayName) {
              context
                  .read<DatabaseBloc>()
                  .add(DatabaseUserFetched(displayName));
            }
            if (state is DatabaseInitial) {
              context
                  .read<DatabaseBloc>()
                  .add(DatabaseUserFetched(displayName));
              return const Center(child: CircularProgressIndicator());
            } else if (state is DatabaseUserFetchedSuccess) {
              if (state.listOfUserData.isEmpty) {
                return const Center(
                  child: Text(Constants.textNoData),
                );
              } else {
                return Column(
                  children: [
                    Flexible(
                      child: Container(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height,
                            maxWidth: MediaQuery.of(context).size.width,
                            minHeight: MediaQuery.of(context).size.height * 0.5,
                            minWidth: MediaQuery.of(context).size.width * 0.5,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: UserLocationPoc()),
                    ),
                    Flexible(
                      child: Center(
                        child: ListView.builder(
                          itemCount: state.listOfUserData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                title: Text(
                                    state.listOfUserData[index].displayName!),
                                subtitle:
                                    Text(state.listOfUserData[index].email!),
                                trailing: Text(state.listOfUserData[index].age!
                                    .toString()),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const GroupCreationView()),
                    (route) => false,
                  );
                },
                child: const Text('Create new Group!')),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => GroupOverviewView()),
                    (route) => false,
                  );
                },
                child: const Text('Group Overview!')),
          ],
        ),
      );
    });
  }
}
