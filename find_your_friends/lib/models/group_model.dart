import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  String? groupName;
  String? creator;
  List<String>? members;
  String? description;

  GroupModel({this.groupName, this.creator, this.members, this.description});

  Map<String, dynamic> toMap() {
    return {
      'groupName': groupName,
      'creator': creator,
      'description': description,
    };
  }

  GroupModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : groupName = doc.data()!["groupName"],
        creator = doc.data()!["creator"],
        description = doc.data()!["description"];

  GroupModel copyWith({
    String? groupName,
    String? creator,
    List<String>? members,
    String? description,
  }) {
    return GroupModel(
      groupName: groupName ?? this.groupName,
      creator: creator ?? this.creator,
      members: members ?? this.members,
      description: description ?? this.description,
    );
  }
}
