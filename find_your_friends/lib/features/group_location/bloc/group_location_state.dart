part of 'group_location_bloc.dart';

@immutable
sealed class GroupLocationState extends Equatable {
  @override
  List<Object?> get props => [];
}

// final class GroupLocationInitialState extends GroupLocationState {
//   final String groupId;
//   GroupLocationInitialState({required this.groupId});
//   @override
//   List<Object?> get props => [];
// }

class GroupLocationUpdateState extends GroupLocationState {
  final List<GroupLocation> groupLocations;
  final String groupId;
  GroupLocationUpdateState(
      {required this.groupLocations, required this.groupId});

  GroupLocationUpdateState copyWith(
      {List<GroupLocation>? groupLocations, String? groupId}) {
    return GroupLocationUpdateState(
        groupLocations: groupLocations ?? this.groupLocations,
        groupId: groupId ?? this.groupId);
  }

  @override
  List<Object?> get props => [groupId, groupLocations];
}

class GroupLocationErrorState extends GroupLocationState {}

// class GroupLocationDetailState extends GroupLocationState{
//   final String groupId
// }
