import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kanglei_taxi_operator/conts/firebase/color_constants.dart';
import 'package:kanglei_taxi_operator/models/booking_order.dart';
import 'package:kanglei_taxi_operator/provider/livemap.dart';
import 'package:kanglei_taxi_operator/provider/order_list.dart';
import 'package:kanglei_taxi_operator/views/add_taxi.dart';
import 'package:kanglei_taxi_operator/views/live_map.dart';
import 'package:latlong2/latlong.dart';

import 'order_list.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<int> getTotalTaxis() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('taxi_fees').get();
    return snapshot.docs.length;
  }

  Future<int> getTotalCustomers() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    return snapshot.docs.length;
  }

  final OrderliveListController controller = Get.put(OrderliveListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("images/logo3D.png"),
        title: Text("KANGLEI_TAXI OPERATOR"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    double totalSales = 0.0;
                    double todaySales = 0.0;

                    snapshot.data!.docs.forEach((DocumentSnapshot document) {
                      double amount = double.parse(document['fees'] ?? '0.0');
                      totalSales += amount;

                      DateTime bookingDate = (document['date'] as Timestamp).toDate();
                      if (isToday(bookingDate)) {
                        todaySales += amount;
                      }
                    });

                    return FutureBuilder(
                      future: Future.wait([getTotalTaxis(), getTotalCustomers()]),
                      builder: (BuildContext context, AsyncSnapshot<List<int>> futureSnapshot) {
                        if (futureSnapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        int totalTaxis = futureSnapshot.data![0];
                        int totalCustomers = futureSnapshot.data![1];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children: [
                              _buildStatCard(
                                'Total Sales',
                                '₹ ${totalSales.toStringAsFixed(2)}',
                                "images/total_sales.svg",
                              ),
                              _buildStatCard(
                                'Today\'s Sales',
                                '₹ ${todaySales.toStringAsFixed(2)}',
                                "images/total_sales.svg",
                              ),
                              _buildStatCard(
                                'Monthly\'s',
                                '₹ ${totalCustomers.toStringAsFixed(2)}',
                                "images/total_sales.svg",
                              ),
                              _buildStatCard('Taxis', totalTaxis, "images/taxi.svg"),
                              _buildStatCard('Customers', totalCustomers, "images/service.svg"),
                              _buildStatCard('Operator', totalCustomers, "images/operator.svg"),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height/3, // Adjusted height
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Taxi List",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AddTaxi()),
                            );
                          },
                            child: Text("Add New",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                      ],
                    ),
                    Expanded( // Added Expanded widget
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('taxi_fees').snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          return ListView(
                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                              return ListTile(
                                title: Text(data['type']),
                                subtitle: Text('Fare: ${data['fare_fees']}'),
                                leading: Image.network(data['driver_photo_url']),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   height: MediaQuery.of(context).size.height/3,
              //   child: Column(
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text("Live Map",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              //           InkWell(
              //               onTap: (){
              //                 Navigator.push(
              //                   context,
              //                   MaterialPageRoute(builder: (context) => AddTaxi()),
              //                 );
              //               },
              //               child: Text("Full Screen",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
              //
              //         ],
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );

  }

  Widget _buildStatCard(String title, amount, images) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            images,
            width: 40,
            height: 40,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12, // Adjust the font size as needed
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$amount',
            style: TextStyle(
              fontSize: 14, // Adjust the font size as needed
            ),
          ),
        ],
      ),
    );
  }

  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

}
