import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

part 'user_location_event.dart';
part 'user_location_state.dart';

class UserLocationBloc
    extends Bloc<UserLocationEvent, UserLocationUpdateState> {
  UserLocationBloc()
      : super(UserLocationUpdateState(userLocation: LocationData.fromMap({}))) {
    on<UpdateUserLocationEvent>(_onUpdateUserLocationEvent);
  }

  void _onUpdateUserLocationEvent(
      UpdateUserLocationEvent event, Emitter<UserLocationUpdateState> emit) {
    emit(state.copyWith(userLocation: event.userLocation));
  }
}
