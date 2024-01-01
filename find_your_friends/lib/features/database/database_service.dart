import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<List<GroupModel>> retrieveGroupData() async {
    User user = auth.currentUser!;
    DocumentSnapshot<Map<String, dynamic>> userGroups =
        await _db.collection(Constants.fbUserGroups).doc(user.uid).get();
    var tmp = userGroups.data()!;
    if (kDebugMode) {
      print("tmp: $tmp");
    }
    return [];
  }
}
