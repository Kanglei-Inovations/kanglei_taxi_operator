import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kanglei_taxi_operator/models/dashboard_data.dart';

class SalesDataProvider extends ChangeNotifier {
  SalesData? _salesData;

  SalesData? get salesData => _salesData;

  Future<void> fetchData() async {
    try {
      double totalSales = 0.0;
      double todaySales = 0.0;
      int totalTaxis = 0;
      int totalCustomers = 0;

      QuerySnapshot bookingsSnapshot = await FirebaseFirestore.instance.collection('bookings').get();
      bookingsSnapshot.docs.forEach((document) {
        double amount = double.parse(document['fees'] ?? '0.0');
        totalSales += amount;

        DateTime bookingDate = (document['date'] as Timestamp).toDate();
        if (isToday(bookingDate)) {
          todaySales += amount;
        }
      });

      QuerySnapshot taxisSnapshot = await FirebaseFirestore.instance.collection('taxi_fees').get();
      totalTaxis = taxisSnapshot.docs.length;

      QuerySnapshot usersSnapshot = await FirebaseFirestore.instance.collection('users').get();
      totalCustomers = usersSnapshot.docs.length;

      _salesData = SalesData(
        totalSales: totalSales,
        todaySales: todaySales,
        totalTaxis: totalTaxis,
        totalCustomers: totalCustomers,
      );

      notifyListeners();

      // Call the printData() method to print the fetched data
      printData();
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  // Method to print the fetched data
  void printData() {
    print('Total Sales: ${_salesData?.totalSales}');
    print('Today\'s Sales: ${_salesData?.todaySales}');
    print('Total Taxis: ${_salesData?.totalTaxis}');
    print('Total Customers: ${_salesData?.totalCustomers}');
  }
}
