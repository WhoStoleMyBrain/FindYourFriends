import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_your_friends/features/location/location_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationService locService = LocationService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<List<LatLng>> watchLocationData() async* {
    final doc = _firestore.collection('location').snapshots();
    yield* doc.map((snapshot) => snapshot.docs
        .map((e) => LatLng(e.get('latitude'), e.get('longitude')))
        .toList());
  }
}

abstract class LocationRepository {
  Stream<List<LatLng>> watchLocationData();
}
