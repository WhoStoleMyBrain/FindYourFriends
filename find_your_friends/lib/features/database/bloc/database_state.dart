part of 'database_bloc.dart';

abstract class DatabaseState extends Equatable {
  const DatabaseState();

  @override
  List<Object?> get props => [];
}

class DatabaseInitial extends DatabaseState {}

class DatabaseUserFetchedSuccess extends DatabaseState {
  final List<UserModel> listOfUserData;
  final String? displayName;
  const DatabaseUserFetchedSuccess(this.listOfUserData, this.displayName);

  @override
  List<Object?> get props => [listOfUserData, displayName];
}

class DatabaseGroupFetchedSuccess extends DatabaseState {
  final List<GroupModel> groups;
  const DatabaseGroupFetchedSuccess(this.groups);

  @override
  List<Object?> get props => [groups];
}

class DatabaseError extends DatabaseState {
  @override
  List<Object?> get props => [];
}
