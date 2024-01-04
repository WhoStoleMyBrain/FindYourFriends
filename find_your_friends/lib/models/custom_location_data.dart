import 'package:location/location.dart';

class LocationDataImpl implements LocationData {
  LocationDataImpl(
    this.latitude,
    this.longitude,
    this.accuracy,
    this.altitude,
    this.speed,
    this.speedAccuracy,
    this.heading,
    this.time,
    this.isMock,
    this.verticalAccuracy,
    this.headingAccuracy,
    this.elapsedRealtimeNanos,
    this.elapsedRealtimeUncertaintyNanos,
    this.satelliteNumber,
    this.provider,
  );

  factory LocationDataImpl.fromLocationData(LocationData data) {
    return LocationDataImpl(
        data.latitude,
        data.longitude,
        data.accuracy,
        data.altitude,
        data.speed,
        data.speedAccuracy,
        data.heading,
        data.time,
        data.isMock,
        data.verticalAccuracy,
        data.headingAccuracy,
        data.elapsedRealtimeNanos,
        data.elapsedRealtimeUncertaintyNanos,
        data.satelliteNumber,
        data.provider);
  }

  /// Creates a new [LocationData] instance from a map.
  factory LocationDataImpl.fromMap(Map<String, dynamic> dataMap) {
    return LocationDataImpl(
      dataMap['latitude'] as double?,
      dataMap['longitude'] as double?,
      dataMap['accuracy'] as double?,
      dataMap['altitude'] as double?,
      dataMap['speed'] as double?,
      dataMap['speed_accuracy'] as double?,
      dataMap['heading'] as double?,
      dataMap['time'] as double?,
      dataMap['isMock'] == 1,
      dataMap['vertical_accuracy'] as double?,
      dataMap['heading_accuracy'] as double?,
      dataMap['elapsed_realtime_nanos'] as double?,
      dataMap['elapsed_realtime_uncertainty_nanos'] as double?,
      dataMap['satellite_number'] as int?,
      dataMap['provider'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy,
      'altitude': altitude,
      'speed': speed,
      'speed_accuracy': speedAccuracy,
      'heading': heading,
      'time': time,
      'isMock': isMock,
      'vertical_accuracy': verticalAccuracy,
      'heading_accuracy': headingAccuracy,
      'elapsed_realtime_nanos': elapsedRealtimeNanos,
      'elapsed_realtime_uncertainty_nanos': elapsedRealtimeUncertaintyNanos,
      'satellite_number': satelliteNumber,
      'provider': provider,
    };
  }

  /// Latitude in degrees
  final double? latitude;

  /// Longitude, in degrees
  final double? longitude;

  /// Estimated horizontal accuracy of this location, radial, in meters
  ///
  /// Always 0 on Web
  final double? accuracy;

  /// Estimated vertical accuracy of this location, in meters.
  final double? verticalAccuracy;

  /// In meters above the WGS 84 reference ellipsoid. Derived from GPS informations.
  ///
  /// Always 0 on Web
  final double? altitude;

  /// In meters/second
  ///
  /// Always 0 on Web
  final double? speed;

  /// In meters/second
  ///
  /// Always 0 on Web
  final double? speedAccuracy;

  /// Heading is the horizontal direction of travel of this device, in degrees
  ///
  /// Always 0 on Web
  final double? heading;

  /// timestamp of the LocationData
  final double? time;

  /// Is the location currently mocked
  ///
  /// Always false on iOS
  final bool? isMock;

  /// Get the estimated bearing accuracy of this location, in degrees.
  /// Only available on Android
  /// https://developer.android.com/reference/android/location/Location#getBearingAccuracyDegrees()
  final double? headingAccuracy;

  /// Return the time of this fix, in elapsed real-time since system boot.
  /// Only available on Android
  /// https://developer.android.com/reference/android/location/Location#getElapsedRealtimeNanos()
  final double? elapsedRealtimeNanos;

  /// Get estimate of the relative precision of the alignment of the ElapsedRealtimeNanos timestamp.
  /// Only available on Android
  /// https://developer.android.com/reference/android/location/Location#getElapsedRealtimeUncertaintyNanos()
  final double? elapsedRealtimeUncertaintyNanos;

  /// The number of satellites used to derive the fix.
  /// Only available on Android
  /// https://developer.android.com/reference/android/location/Location#getExtras()
  final int? satelliteNumber;

  /// The name of the provider that generated this fix.
  /// Only available on Android
  /// https://developer.android.com/reference/android/location/Location#getProvider()
  final String? provider;

  @override
  String toString() =>
      'LocationData<lat: $latitude, long: $longitude${(isMock ?? false) ? ', mocked' : ''}>';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationData &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          accuracy == other.accuracy &&
          altitude == other.altitude &&
          speed == other.speed &&
          speedAccuracy == other.speedAccuracy &&
          heading == other.heading &&
          time == other.time &&
          isMock == other.isMock;

  @override
  int get hashCode =>
      latitude.hashCode ^
      longitude.hashCode ^
      accuracy.hashCode ^
      altitude.hashCode ^
      speed.hashCode ^
      speedAccuracy.hashCode ^
      heading.hashCode ^
      time.hashCode ^
      isMock.hashCode;
}

class CustomLocationData2 {
  LocationDataImpl? locationData;
}
