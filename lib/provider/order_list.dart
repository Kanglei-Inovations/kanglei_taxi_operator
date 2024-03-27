import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kanglei_taxi_operator/models/booking_order.dart';
import 'package:latlong2/latlong.dart';
class OrderListController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<BookingOrder> orderList = <BookingOrder>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrderList();
  }

  void fetchOrderList() {
    _firestore.collection('bookings').snapshots().listen((snapshot) {
      final List<BookingOrder> orders = [];
      snapshot.docs.forEach((doc) {
        final userId = doc['userId'];
        _firestore.collection('users').doc(userId).get().then((userDoc) {
          orders.add(BookingOrder(
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
          ));
          orderList.assignAll(orders);
        });
      });
    });

  }
}
