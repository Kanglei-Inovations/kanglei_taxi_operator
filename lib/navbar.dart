import 'dart:ui';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:kanglei_taxi_operator/views/dashboard.dart';
import 'package:kanglei_taxi_operator/views/live_map.dart';
import 'package:kanglei_taxi_operator/views/order_list.dart';


import 'conts/firebase/color_constants.dart';


class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final _pages = [Dashboard(), const OrderList(),const LiveMap(), const LiveMap()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), // Adjust the values as needed
          topRight: Radius.circular(20.0), // Adjust the values as needed
        ),
        child: IndexedStack(index: _currentIndex, children: _pages),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), // Adjust the values as needed
          topRight: Radius.circular(20.0), // Adjust the values as needed
        ),
        child: BottomNavyBar(
          containerHeight: 60,
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.elasticInOut,
          onItemSelected: (index) => setState(() => _currentIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.local_taxi_rounded),
              title: Text('Home', style: Theme.of(context).textTheme.bodyLarge),
              activeColor: AppColors.secondary,
              inactiveColor: AppColors.primary,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.history),
              title: Text('Orders', style: Theme.of(context).textTheme.bodyLarge),
              activeColor: AppColors.secondary,
              inactiveColor: AppColors.primary,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Badge(
                label: Text('2'),
                child: Icon(Icons.messenger_sharp),
              ),
              title: Text('Map', style: Theme.of(context).textTheme.bodyLarge),
              activeColor: AppColors.secondary,
              inactiveColor: AppColors.primary,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings',style: Theme.of(context).textTheme.bodyLarge),
              activeColor: AppColors.secondary,
              inactiveColor: AppColors.primary,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
