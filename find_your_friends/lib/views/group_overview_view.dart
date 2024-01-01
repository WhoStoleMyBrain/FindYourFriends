import 'package:find_your_friends/features/database/bloc/database_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupOvervieweView extends StatelessWidget {
  const GroupOvervieweView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create your own Group'),
      ),
      body: BlocBuilder<DatabaseBloc, DatabaseState>(
        builder: (context, state) {
          if (state is DatabaseGroupFetchedSuccess) {
            return ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(state.groups[index].groupName!),
                    subtitle: Text(state.groups[index].description!),
                    trailing: Text(state.groups[index].creator!),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
