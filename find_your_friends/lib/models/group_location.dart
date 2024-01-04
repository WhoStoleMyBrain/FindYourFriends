import 'package:find_your_friends/models/custom_location_data.dart';

final class GroupLocation {
  String? groupId;
  String? userName;
  LocationDataImpl? userLocation;

  GroupLocation({this.groupId, this.userName, this.userLocation});

  GroupLocation copyWith({
    String? groupId,
    String? userName,
    LocationDataImpl? userLocation,
  }) {
    return GroupLocation(
      groupId: groupId ?? this.groupId,
      userName: userName ?? this.userName,
      userLocation: userLocation ?? this.userLocation,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'groupName': groupName,
  //     'creator': creator,
  //     'description': description,
  //     'creatorId': creatorId,
  //   };
  // }

  // GroupLocation.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
  //     : groupName = doc.data()!["groupName"],
  //       creator = doc.data()!["creator"],
  //       description = doc.data()!["description"],
  //       creatorId = doc.data()!["description"];
}
