import 'package:bloc/bloc.dart';
import 'package:find_your_friends/features/database/bloc/database_repository.dart';
import 'package:find_your_friends/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseRepository _databaseRepository;
  DatabaseBloc(this._databaseRepository) : super(DatabaseInitial()) {
    on<DatabaseFetched>(_fetchUserData);
  }

  _fetchUserData(DatabaseFetched event, Emitter<DatabaseState> emit) async {
    List<UserModel> listofUserData =
        await _databaseRepository.retrieveUserData();
    emit(DatabaseSuccess(listofUserData, event.displayName));
  }
}
