import 'package:find_your_friends/features/authentication/bloc/authentication_bloc.dart';
import 'package:find_your_friends/features/database/bloc/database_bloc.dart';
import 'package:find_your_friends/pages/standard_page.dart';
import 'package:find_your_friends/widgets/user_location_poc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Widget _getWidgetsForDatabaseState(
      BuildContext context, DatabaseState state) {
    if (state is DatabaseInitial) {
      return const CircularProgressIndicator();
    } else if (state is DatabaseUserFetchedSuccess) {
      return SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                maxWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height * 0.5,
                minWidth: MediaQuery.of(context).size.width * 0.5,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: UserLocationPoc()),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height *
                0.1, //TODO change height value!!
            // height: MediaQuery.of(context).size.height * 0.1,
            child: ListView.builder(
              itemCount: state.listOfUserData.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(state.listOfUserData[index].displayName!),
                    subtitle: Text(state.listOfUserData[index].email!),
                    trailing: Text(state.listOfUserData[index].age!.toString()),
                  ),
                );
              },
            ),
          ),
        ]),
      );
    }
    return const CircularProgressIndicator();
  }

  void _listenBasedOnState(BuildContext context, DatabaseState state) {
    String? displayName =
        (context.read<AuthenticationBloc>().state as AuthenticationSuccess)
            .displayName;
    if (state is DatabaseUserFetchedSuccess &&
        displayName !=
            (context.read<DatabaseBloc>().state as DatabaseUserFetchedSuccess)
                .displayName) {
      context.read<DatabaseBloc>().add(DatabaseUserFetched(displayName));
    }
    if (state is DatabaseInitial) {
      context.read<DatabaseBloc>().add(DatabaseUserFetched(displayName));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StandardPage(
        widget: BlocConsumer<DatabaseBloc, DatabaseState>(
          builder: (context, state) {
            String? displayName = (context.read<AuthenticationBloc>().state
                    as AuthenticationSuccess)
                .displayName;

            if (state is DatabaseInitial) {
              context
                  .read<DatabaseBloc>()
                  .add(DatabaseUserFetched(displayName));
            }
            return _getWidgetsForDatabaseState(context, state);
          },
          buildWhen: (previous, current) {
            if (previous is DatabaseInitial) {
              String? displayName = (context.read<AuthenticationBloc>().state
                      as AuthenticationSuccess)
                  .displayName;
              if (current is DatabaseUserFetchedSuccess &&
                  displayName !=
                      (context.read<DatabaseBloc>().state
                              as DatabaseUserFetchedSuccess)
                          .displayName) {
                context
                    .read<DatabaseBloc>()
                    .add(DatabaseUserFetched(displayName));
              }
              if (current is DatabaseInitial) {
                context
                    .read<DatabaseBloc>()
                    .add(DatabaseUserFetched(displayName));
              }
            }
            return true;
          },
          listener: (context, state) {
            _listenBasedOnState(context, state);
          },
        ),
        title: "Home View");
  }
}
