import 'package:find_your_friends/views/group_creation_view.dart';
import 'package:flutter/material.dart';

import '../views/group_overview_view.dart';

class StandardFloatingActionButtons extends StatelessWidget {
  const StandardFloatingActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
            key: GlobalKey(),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => GroupOverviewView()),
                (route) => false,
              );
            },
            child: const Text('Group Overview!')),
      ],
    );
  }
}
