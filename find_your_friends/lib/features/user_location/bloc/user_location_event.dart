part of 'user_location_bloc.dart';

abstract class UserLocationEvent extends Equatable {
  const UserLocationEvent();

  @override
  List<Object?> get props => [];
}

class UpdateUserLocationEvent extends UserLocationEvent {
  final LocationData userLocation;
  const UpdateUserLocationEvent(this.userLocation);

  @override
  List<Object?> get props => [userLocation];
}
