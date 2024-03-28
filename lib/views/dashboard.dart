import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:kanglei_taxi_operator/conts/firebase/color_constants.dart';
import 'package:kanglei_taxi_operator/models/booking_order.dart';
import 'package:kanglei_taxi_operator/provider/livemap.dart';
import 'package:kanglei_taxi_operator/provider/order_list.dart';
import 'package:latlong2/latlong.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final OrderliveListController controller = Get.put(OrderliveListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Color(0xFF836FFF),
        title: Text('KANGLEITAXI OPERATOR'),
        actions: [
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Obx(() {
            if (controller.liveorder.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else {
              return FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(24.8090634, 93.9436556),
                  initialZoom: 9,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.kangleiinovations.kanglei_taxi',
                  ),
                  MarkerLayer(
                    markers: controller.liveorder.map((liveData) {
                      return Marker(
                        point: LatLng(
                          liveData.currentPosition.latitude,
                          liveData.currentPosition.longitude,
                        ),
                        width: 80,
                        height: 80,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'CUSTOMER: ${liveData.displayName} | ${liveData.phoneNumber}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'DATE : ${liveData.date}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                              ),
                                            ),
                                            Divider(
                                              height: 10.0,
                                              color: Colors.amber.shade500,
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.place,
                                                    color: Colors.green),
                                                SizedBox(width: 2),
                                                Expanded(
                                                  child: Text(
                                                    'PIKUP: ${liveData.pickupLocation}, ${liveData.pickupLocation}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.business),
                                                SizedBox(width: 2),
                                                Expanded(
                                                  child: Text(
                                                    'DESTINATION: ${liveData.destinationLocation}, ${liveData.destinationLocation}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              height: 10.0,
                                              color: Colors.amber.shade500,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                // Display order ID
                                                Container(
                                                  padding: EdgeInsets.all(3.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        'PAYMENT',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2,
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 3.0),
                                                        child: Text(
                                                          liveData.status,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .subtitle1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Display order amount
                                                Container(
                                                  padding: EdgeInsets.all(3.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        'FARE',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 3.0),
                                                        child: Text(
                                                          '₹ ' +
                                                              liveData.fees
                                                                  .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .subtitle2,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(3.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        'DISTANCE',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2,
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 3.0),
                                                        child: Text(
                                                          liveData.distance,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .subtitle1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Display payment status
                                                Container(
                                                  padding: EdgeInsets.all(3.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        'TRIP',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 3.0),
                                                        child: Text(
                                                          liveData.driveStatus,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .subtitle1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Display payment type
                                              ],
                                            ),
                                            Divider(
                                              height: 10.0,
                                              color: Colors.amber.shade500,
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Close'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(liveData.photoUrl),
                                radius: 20,
                                // Adjust the size as needed
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.transparent,
                                child: ClipOval(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.red,
                                        // Adjust border color as needed
                                        width:
                                            2, // Adjust border width as needed
                                      ),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: liveData.photoUrl,
                                      width: 40, // Adjust image size as needed
                                      height: 40, // Adjust image size as needed
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.location_on,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            }
          }),
        
        ],
      ),
    );
  }
}
