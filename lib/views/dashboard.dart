import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("images/logo3D.png"),
        title: Text("KANGLEI_TAXI OPERATOR"),
      ),
      body: Column(
        children: [
          Text("Sales Data"),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                double totalSales = 0.0;
                double todaySales = 0.0;
                int totalTaxis = 0;
                int totalCustomers = 0;

                // Calculate total sales and today's sales
                snapshot.data!.docs.forEach((DocumentSnapshot document) {
                  double amount = double.parse(document['fees'] ?? '0.0');
                  totalSales += amount;

                  DateTime bookingDate = (document['date'] as Timestamp).toDate();
                  if (isToday(bookingDate)) {
                    todaySales += amount;
                  }
                });

                // Query taxi_fees collection to get total taxis
                FirebaseFirestore.instance.collection('bookings').get().then((QuerySnapshot snapshot) {
                  totalTaxis = snapshot.docs.length;
                  print(totalTaxis);
                });

                // Query users collection to get total customers
                FirebaseFirestore.instance.collection('users').get().then((QuerySnapshot snapshot) {
                  totalCustomers = snapshot.docs.length;
                });

                return GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  padding: EdgeInsets.all(10),
                  children: [
                    _buildStatCard('Total Sales', '₹ ${totalSales}'),
                    _buildStatCard('Today\'s Sales', '₹ ${todaySales}'),
                    _buildStatCard('Total Taxis', totalTaxis),
                    _buildStatCard('Total Customers', totalCustomers),
                  ],
                );
              },
            ),
          ),

        ],
      ),
    );
  }


  Widget _buildStatCard(String title, amount) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '$amount',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }


  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }
}
