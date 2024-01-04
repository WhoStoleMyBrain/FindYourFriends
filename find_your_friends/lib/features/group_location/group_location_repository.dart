import 'package:find_your_friends/features/group_location/group_location_service.dart';

import '../../models/group_location.dart';
import '../database/database_service.dart';

class GroupLocationRepositoryImpl implements GroupLocationRepository {
  GroupLocationService groupLocService = GroupLocationService();
  final DatabaseService dbService = DatabaseService();

  @override
  Stream<List<GroupLocation>> listenToGroupLocation(String groupId) {
    return dbService.listenToGroupLocation(groupId);
  }
}

abstract class GroupLocationRepository {
  Stream<List<GroupLocation>> listenToGroupLocation(String groupId);
}
