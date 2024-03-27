import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanglei_taxi_operator/conts/firebase/color_constants.dart';
import 'package:kanglei_taxi_operator/models/booking_order.dart';
import 'package:kanglei_taxi_operator/provider/order_list.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final OrderListController controller = Get.put(OrderListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Obx(() => ListView.builder(
            itemCount: controller.orderList.length,
            itemBuilder: (context, index) {
              BookingOrder order = controller.orderList[index];
              return Dismissible(
                key: UniqueKey(), // Unique key for each Dismissible widget
                direction: DismissDirection.endToStart,
                background: Container(
                  color: AppColors.burningorage,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    // Show a confirmation dialog before deletion (optional)
                    return await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Confirm Deletion"),
                        content:
                            Text("Are you sure you want to Cancel Booking"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(false); // Cancel deletion
                            },
                            child: Text("Close"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(true); // Confirm deletion
                            },
                            child: Text("Ok"),
                          ),
                        ],
                      ),
                    );
                  }
                  return false;
                },
                onDismissed: (direction) {
                  // Delete the document from Firestore
                  FirebaseFirestore.instance
                      .collection('bookings')
                      .doc(order.id)
                      .delete();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Card(
                    elevation: 4,
                    child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Booking Date : ${order.date}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          Divider(
                            height: 10.0,
                            color: Colors.amber.shade500,
                          ),
                          Row(
                            children: [
                              Icon(Icons.place, color: Colors.green),
                              SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  ' ${order.pickupLocation}',
                                  overflow: TextOverflow.ellipsis,
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
                                  ' ${order.destinationLocation}',
                                  overflow: TextOverflow.ellipsis,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Display order ID
                              Container(
                                padding: EdgeInsets.all(3.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Payment Status',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 3.0),
                                      child: Text(
                                        order.status,
                                        style: Theme.of(context)
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Fare Amount',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 3.0),
                                      child: Text(
                                        '₹ ' + order.fees.toString(),
                                        style: Theme.of(context)
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Car Type',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top: 3.0),
                                        child: Text(
                                          order.type,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        )),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                child: Text(
                                  "Invoice",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors
                                      .primary, // Set the background color to red
                                ),
                              ),
                              ElevatedButton(
                                child: Text('Payment'),
                                onPressed: () {
                                  _showPaymentPopup(context, order);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors
                                      .primary, // Set the background color to red
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }

  final InputDecoration customInputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.only(left: 2.0),
    focusColor: Colors.greenAccent,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.deepOrange),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Colors.white,
      ),
    ),
    // Other common styles can be added here
  );

  void _showPaymentPopup(BuildContext context, BookingOrder order) {
    TextEditingController _linkTextController = TextEditingController();
    TextEditingController _amountTextController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Details'),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TextFormField(
                  //   decoration: InputDecoration(labelText: 'QR Code'),
                  // ),
                  // SizedBox(height: 10.0),
                  TextFormField(
                    controller: _linkTextController,
                    decoration:
                        customInputDecoration.copyWith(labelText: 'Input Link'),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _amountTextController,
                    decoration:
                        customInputDecoration.copyWith(labelText: 'Amount'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {},
              child: Text('Paid'),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('bookings')
                    .doc(order.id)
                    .update({
                  'fees': _amountTextController.text,
                  'paymentLink': _linkTextController.text,
                }).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Payment details updated successfully'),
                  ));
                  Navigator.of(context).pop();
                }).catchError((error) {
                  print('Error updating payment details: $error');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Failed to update payment details'),
                  ));
                });
              },
              child: Text(
                'Update',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}
