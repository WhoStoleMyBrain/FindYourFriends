import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_your_friends/models/custom_location_data.dart';
import 'package:find_your_friends/models/group_location.dart';
import 'package:find_your_friends/models/group_model.dart';
import 'package:find_your_friends/models/user_model.dart';
import 'package:find_your_friends/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  addUserData(UserModel userData) async {
    await _db
        .collection(Constants.fbUsers)
        .doc(userData.uid)
        .set(userData.toMap());
  }

  createNewGroup(UserModel user, GroupModel group) async {
    // create group and get new group uid
    DocumentReference<Map<String, dynamic>> groupRef =
        await _db.collection(Constants.fbGroups).add(group.toMap());
    // add users in group
    DocumentReference<Map<String, dynamic>> userGroupsRef =
        _db.collection(Constants.fbUserGroups).doc(user.uid);
    DocumentSnapshot<Map<String, dynamic>> result = await userGroupsRef.get();
    if (result.exists) {
      userGroupsRef.update({groupRef.id: true});
    } else {
      userGroupsRef.set({groupRef.id: true});
    }

    List<String>? updatedMembers = group.members?..add(user.uid!);
    DocumentReference<Map<String, dynamic>> groupUsersRef =
        _db.collection(Constants.fbGroupUsers).doc(groupRef.id);
    DocumentSnapshot<Map<String, dynamic>> groupResult =
        await groupUsersRef.get();
    if (groupResult.exists) {
      groupUsersRef.update(
          updatedMembers!.asMap().map((key, value) => MapEntry(value, true)));
    } else {
      groupUsersRef.set(
          updatedMembers!.asMap().map((key, value) => MapEntry(value, true)));
    }
  }

  Future<List<UserModel>> retrieveUserData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection(Constants.fbUsers).get();
    return snapshot.docs
        .map((docSnapshot) => UserModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<String> retrieveUserName(UserModel user) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection(Constants.fbUsers).doc(user.uid).get();
    return snapshot.data()!["displayName"];
  }

  Stream<List<GroupModel>> retrieveGroupData() async* {
    //TODO Add Pagination to request when filtering for userGroups (whereIn, see Firebase Documentation, currently limited to 30 requests)
    //TODO Refactor to actual stream (updating values when data is changed... use .snapshots())
    User user = auth.currentUser!;
    DocumentSnapshot<Map<String, dynamic>> userGroups =
        await _db.collection(Constants.fbUserGroups).doc(user.uid).get();
    Map<String, dynamic> userGroupsData = userGroups.data()!;
    userGroupsData.removeWhere((key, value) => value == false);
    List<GroupModel> groups = await _db
        .collection(Constants.fbGroups)
        .where(FieldPath.documentId, whereIn: userGroupsData.keys)
        .get()
        .then((value) =>
            value.docs.map((e) => GroupModel.fromDocumentSnapshot(e)).toList());
    yield groups;
  }

  Stream<List<GroupLocation>> listenToGroupLocation(String groupId) async* {
    //TODO Refactor whereIn to use pagination, since only 30 entries are allowed.
    //TODO Only necessary of groups > 30 people are allowed
    // Returns all the user ids in this group, with value either true or false
    Map<String, dynamic>? groupUsersData = await _db
        .collection(Constants.fbGroupUsers)
        .doc(groupId)
        .get()
        .then((value) => value.data()?..removeWhere((key, value) => !value));
    Stream<QuerySnapshot<Map<String, dynamic>>> locationData = _db
        .collection(Constants.fbLocation)
        .where(FieldPath.documentId, whereIn: groupUsersData?.keys)
        .snapshots();

    // latitude: 37.4219983
    // longitude: -122.084
    await for (QuerySnapshot<Map<String, dynamic>> entry in locationData) {
      yield entry.docs
          .map((e) => GroupLocation(
              groupId: groupId,
              userName: e.data()["name"],
              userLocation: LocationDataImpl.fromMap(e.data())))
          .toList();
    }
  }
}
