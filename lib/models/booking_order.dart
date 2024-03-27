import 'package:latlong2/latlong.dart';

class BookingOrder {
  final String id;
  final String type;
  final String fees;
  final String pickupLocation;
  final String destinationLocation;
  final DateTime date;
  final String distance;
  final LatLng currentPosition;
  final LatLng destinationPosition;
  final String status;
  final String displayName;
  final String phoneNumber;
  final String photoUrl;

  BookingOrder({
    required this.id,
    required this.type,
    required this.fees,
    required this.pickupLocation,
    required this.destinationLocation,
    required this.date,
    required this.distance,
    required this.currentPosition,
    required this.destinationPosition,
    required this.status,
    required this.displayName,
    required this.phoneNumber,
    required this.photoUrl,
  });
}
