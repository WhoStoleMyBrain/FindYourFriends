import 'package:location/location.dart';

import 'user_location_service.dart';

class LocationRepositoryImpl implements UserLocationRepository {
  UserLocationService userLocService = UserLocationService();

  @override
  Stream<LocationData> userLocation() {
    return userLocService.fetchUserLocation();
  }
}

abstract class UserLocationRepository {
  Stream<LocationData> userLocation();
}
