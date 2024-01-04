import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class UserLocationService {
  final Location loc = Location();

  Stream<LocationData> fetchUserLocation() async* {
    await _requestPermission();
    loc.changeSettings(interval: 1000);
    // final LocationData locationResult = await loc.getLocation();
    yield* loc.onLocationChanged;
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      if (kDebugMode) {
        print('Permission granted for location tracking');
      }
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
