part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoadedState extends LocationState {
  final List<LatLng> locations;
  final String errorMessage;
  const LocationLoadedState(
      {required this.locations, required this.errorMessage});

  LocationLoadedState copyWith(
      {List<LatLng>? locations, String? errorMessage}) {
    return LocationLoadedState(
      locations: locations ?? this.locations,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [locations, errorMessage];
}

class LocationErrorState extends LocationState {}
