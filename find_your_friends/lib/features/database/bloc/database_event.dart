part of 'database_bloc.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object?> get props => [];
}

class DatabaseUserFetched extends DatabaseEvent {
  final String? displayName;
  const DatabaseUserFetched(this.displayName);
  @override
  List<Object?> get props => [displayName];
}

class DatabaseGroupsFetched extends DatabaseEvent {
  final List<GroupModel> groups;
  const DatabaseGroupsFetched(this.groups);

  @override
  List<Object?> get props => [groups];
}
