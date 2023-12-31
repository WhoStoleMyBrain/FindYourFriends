import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../location_repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationLoadedState> {
  final LocationRepository _locationRepository;
  LocationBloc(this._locationRepository)
      : super(const LocationLoadedState(locations: [], errorMessage: '')) {
    on<FetchLocationEvent>(
        // TODO: Update list of locations of users in groups or only the currently viewed group
        // TODO: Transition to either LocationLoadedState or LocationErrorState
        _onFetchLocationEvent);
  }

  void _onFetchLocationEvent(
      FetchLocationEvent event, Emitter<LocationLoadedState> emit) async {
    await emit.forEach(
      _locationRepository.watchLocationData(),
      onData: (List<LatLng> data) {
        return state.copyWith(locations: data);
      },
      onError: (error, stackTrace) {
        if (kDebugMode) {
          print("error: $error, stackTrace: $stackTrace");
        }
        return state.copyWith(errorMessage: error.toString());
      },
    );
  }
}
