import 'package:find_your_friends/features/database/database_service.dart';
import 'package:find_your_friends/models/group_location.dart';
import 'package:find_your_friends/models/group_model.dart';
import 'package:find_your_friends/models/user_model.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  DatabaseService service = DatabaseService();

  @override
  Future<void> saveUserData(UserModel user) {
    return service.addUserData(user);
  }

  @override
  Future<void> createNewGroup(UserModel user, GroupModel group) {
    return service.createNewGroup(user, group);
  }

  @override
  Future<List<UserModel>> retrieveUserData() {
    return service.retrieveUserData();
  }

  @override
  Stream<List<GroupModel>> retrieveGroupData() {
    return service.retrieveGroupData();
  }

  // @override
  // Stream<GroupLocation> listenToGroupLocation(String groupId) {
  //   return service.listenToGroupLocation();
  // }
}

abstract class DatabaseRepository {
  Future<void> saveUserData(UserModel user);
  Future<void> createNewGroup(UserModel user, GroupModel group);
  Future<List<UserModel>> retrieveUserData();
  Stream<List<GroupModel>> retrieveGroupData();
  // Stream<GroupLocation> listenToGroupLocation(String groupId);
}
