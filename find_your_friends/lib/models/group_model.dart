import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  String? groupName;
  String? groupId;
  String? creator;
  List<String>? members;
  String? description;
  String? creatorId;

  GroupModel(
      {this.groupName,
      this.groupId,
      this.creator,
      this.members,
      this.description,
      this.creatorId});

  Map<String, dynamic> toMap() {
    return {
      'groupName': groupName,
      'creator': creator,
      'description': description,
      'creatorId': creatorId,
    };
  }

  GroupModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : groupName = doc.data()!["groupName"],
        creator = doc.data()!["creator"],
        description = doc.data()!["description"],
        creatorId = doc.data()!["description"],
        groupId = doc.id;

  GroupModel copyWith({
    String? groupName,
    String? groupId,
    String? creator,
    List<String>? members,
    String? description,
    String? creatorId,
  }) {
    return GroupModel(
      groupName: groupName ?? this.groupName,
      groupId: groupId ?? this.groupId,
      creator: creator ?? this.creator,
      members: members ?? this.members,
      description: description ?? this.description,
      creatorId: creatorId ?? this.creatorId,
    );
  }
}
