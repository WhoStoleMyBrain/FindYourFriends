import 'package:find_your_friends/features/database/database_repository.dart';
import 'package:find_your_friends/pages/standard_page.dart';
import 'package:find_your_friends/views/group_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/group_location/bloc/group_location_bloc.dart';
import '../models/group_model.dart';

class GroupOverviewView extends StatelessWidget {
  GroupOverviewView({super.key});

  final DatabaseRepository _databaseRepository = DatabaseRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return StandardPage(
        widget: BlocConsumer<GroupLocationBloc, GroupLocationState>(
          builder: (context, state) {
            //TODO: Fix loading of data inside view (probably same error again: rebuild not called once, since initial state is kept...)
            return StreamBuilder(
                stream: _databaseRepository.retrieveGroupData(),
                builder: (context, AsyncSnapshot<List<GroupModel>> snapshot) {
                  print('Inside builder method of stream: $state');
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
                          onTap: () {
                            context.read<GroupLocationBloc>().add(
                                GroupLocationInitialEvent(
                                    groupId: snapshot.data![index].groupId!));
                          },
                        ),
                      );
                    },
                  );
                });
          },
          listener: (context, state) {
            print('Inside listener for state');
            if (state is GroupLocationUpdateState) {
              if (state.groupId != '') {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => GroupDetailView()),
                    (Route<dynamic> route) => false);
              }
            }
          },
        ),
        title: 'Groups Overview');

    // MultiBlocListener(
    //     listeners: [
    //       BlocListener<AuthenticationBloc, AuthenticationState>(
    //         listener: (context, state) {
    //           if (state is AuthenticationFailure) {
    //             Navigator.of(context).pushAndRemoveUntil(
    //                 MaterialPageRoute(
    //                     builder: (context) => const WelcomeView()),
    //                 (Route<dynamic> route) => false);
    //           }
    //         },
    //       ),
    //       BlocListener<GroupLocationBloc, GroupLocationState>(
    //         listener: (context, state) {
    //           if (state is GroupLocationUpdateState) {
    //             if (state.groupId != '') {
    //               Navigator.of(context).pushAndRemoveUntil(
    //                   MaterialPageRoute(
    //                       builder: (context) => GroupDetailView()),
    //                   (Route<dynamic> route) => false);
    //             }
    //           }
    //         },
    //       )
    //     ],
    //     child: Scaffold(
    //       appBar: AppBar(
    //         automaticallyImplyLeading: false,
    //         actions: <Widget>[
    //           IconButton(
    //               icon: const Icon(
    //                 Icons.logout,
    //                 color: Colors.white,
    //               ),
    //               onPressed: () async {
    //                 context
    //                     .read<AuthenticationBloc>()
    //                     .add(AuthenticationSignedOut());
    //               })
    //         ],
    //         systemOverlayStyle:
    //             const SystemUiOverlayStyle(statusBarColor: Colors.blue),
    //         title: const Text("Group Overview"),
    //       ),
    //       body: StreamBuilder(
    //         stream: _databaseRepository.retrieveGroupData(),
    //         builder: (context, AsyncSnapshot<List<GroupModel>> snapshot) {
    //           if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //             return const Center(
    //               child: CircularProgressIndicator(),
    //             );
    //           }
    //           return ListView.builder(
    //             itemCount: snapshot.data!.length,
    //             itemBuilder: (context, index) {
    //               return Card(
    //                 child: ListTile(
    //                   title: Text(snapshot.data![index].groupName!),
    //                   subtitle: Text(snapshot.data![index].description!),
    //                   trailing: Text(snapshot.data![index].creator!),
    //                   onTap: () {
    //                     context.read<GroupLocationBloc>().add(
    //                         GroupLocationInitialEvent(
    //                             groupId: snapshot.data![index].groupId!));
    //                   },
    //                 ),
    //               );
    //             },
    //           );
    //         },
    //       ),
    //       floatingActionButton: ElevatedButton(
    //         onPressed: () {
    //           Navigator.of(context).pushAndRemoveUntil(
    //               MaterialPageRoute(
    //                 builder: (context) => const HomeView(),
    //               ),
    //               (route) => false);
    //         },
    //         child: const Text('Home'),
    //       ),
    //     ));
  }
}
