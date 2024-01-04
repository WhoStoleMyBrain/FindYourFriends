part of 'group_location_bloc.dart';

@immutable
sealed class GroupLocationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GroupLocationInitialEvent extends GroupLocationEvent {
  final String groupId;
  GroupLocationInitialEvent({required this.groupId});
  @override
  List<Object?> get props => [groupId];
}

class UpdateGroupLocationEvent extends GroupLocationEvent {
  final List<GroupLocation> groupLocations;
  UpdateGroupLocationEvent(this.groupLocations);

  @override
  List<Object?> get props => [groupLocations];
}

class UpdateGroupLocationId extends GroupLocationEvent {
  final String groupId;
  UpdateGroupLocationId(this.groupId);

  @override
  List<Object?> get props => [groupId];
}
