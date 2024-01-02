import 'package:find_your_friends/features/database/database_repository.dart';
import 'package:find_your_friends/models/group_model.dart';
import 'package:find_your_friends/models/user_model.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseRepository _databaseRepository;
  DatabaseBloc(this._databaseRepository) : super(DatabaseInitial()) {
    on<DatabaseUserFetched>(_fetchUserData);
    // on<DatabaseGroupsFetched>(_fetchGroupData);
  }

  _fetchUserData(DatabaseUserFetched event, Emitter<DatabaseState> emit) async {
    List<UserModel> listofUserData =
        await _databaseRepository.retrieveUserData();
    emit(DatabaseUserFetchedSuccess(listofUserData, event.displayName));
  }

  // _fetchGroupData(
  //     DatabaseGroupsFetched event, Emitter<DatabaseState> emit) async {
  //   List<GroupModel> groups = await _databaseRepository.retrieveGroupData();
  //   emit(DatabaseGroupFetchedSuccess(groups));
  // }
}
