part of 'user_location_bloc.dart';

abstract class UserLocationState extends Equatable {
  const UserLocationState();

  @override
  List<Object?> get props => [];
}

class UserLocationUpdateState extends UserLocationState {
  final LocationData? userLocation;
  const UserLocationUpdateState({required this.userLocation});

  UserLocationUpdateState copyWith({LocationData? userLocation}) {
    return UserLocationUpdateState(
        userLocation: userLocation ?? this.userLocation);
  }
}

class UserLocationErrorState extends UserLocationState {}
