import 'package:equatable/equatable.dart';
import 'package:find_your_friends/models/group_location.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'group_location_event.dart';
part 'group_location_state.dart';

class GroupLocationBloc
    extends Bloc<GroupLocationEvent, GroupLocationUpdateState> {
  GroupLocationBloc()
      : super(GroupLocationUpdateState(groupLocations: const [], groupId: '')) {
    on<UpdateGroupLocationEvent>(_onUpdateGroupLocationEvent);
    on<UpdateGroupLocationId>(_onUpdateGroupLocationId);
    on<GroupLocationInitialEvent>(_onGroupLocationInitialEvent);
  }

  _onUpdateGroupLocationEvent(
      UpdateGroupLocationEvent event, Emitter<GroupLocationUpdateState> emit) {
    emit(state.copyWith(groupLocations: event.groupLocations));
  }

  _onUpdateGroupLocationId(
      UpdateGroupLocationId event, Emitter<GroupLocationUpdateState> emit) {
    emit(state.copyWith(groupId: event.groupId));
  }

  _onGroupLocationInitialEvent(
      GroupLocationInitialEvent event, Emitter<GroupLocationUpdateState> emit) {
    emit(state.copyWith(groupId: event.groupId));
  }
}
