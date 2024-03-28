import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kanglei_taxi_operator/models/live_map.dart';
import 'package:latlong2/latlong.dart';
class OrderliveListController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<LiveData> liveorder = <LiveData>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchBookingslive();
  }

  void _fetchBookingslive() {
    _firestore.collection('bookings').snapshots().listen((snapshot) {
      final List<LiveData> orderslistlive = [];
      snapshot.docs.forEach((doc) {
        final userId = doc['userId'];
        _firestore.collection('users').doc(userId).get().then((userDoc) {
          // Parse pickupLocation and destinationLocation strings into GeoPoint objects
          print(userDoc.toString());
          orderslistlive.add(LiveData(
            id: doc.id,
            type: doc['type'],
            fees: doc['fees'],
            pickupLocation: doc['pickupLocation'],
            destinationLocation: doc['destinationLocation'],
            date: doc['date'].toDate(),
            distance: doc['distance'],
            currentPosition: LatLng(doc['currentPosition'].latitude, doc['currentPosition'].longitude),
            destinationPosition: LatLng(doc['destinationPosition'].latitude, doc['destinationPosition'].longitude),
            status: doc['status'],
            displayName: userDoc['displayName'],
            phoneNumber: userDoc['phoneNumber'],
            photoUrl: userDoc['photoUrl'],
            driveStatus: '',
          ));
          liveorder.assignAll(orderslistlive);
        });
      });
    });
  }


}
