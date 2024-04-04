import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanglei_taxi_operator/conts/firebase/color_constants.dart';
import 'package:kanglei_taxi_operator/conts/resposive_settings.dart';
import 'package:kanglei_taxi_operator/navbar.dart';
import 'package:kanglei_taxi_operator/views/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _showWelcomePage = false;

  @override
  void initState() {
    super.initState();
    _checkFirstTimeOpening();
  }

  Future<void> _checkFirstTimeOpening() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('first_time') ?? true;

    if (isFirstTime) {
      setState(() {
        _showWelcomePage = true;
      });

      // Mark app as opened for the first time
      await prefs.setBool('first_time', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    return _showWelcomePage ? _buildWelcomePage() : isLoggedIn?Navbar():Navbar()
        ;
  }

  Widget _buildWelcomePage() {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: ResponsiveFile.screenHeight/6,),
                Image(
                  image: AssetImage("images/welcome.png"),
                ),
                SizedBox(height: ResponsiveFile.screenHeight/6,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('KangleiTaxi',
                        style: Theme.of(context).textTheme.headline1),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Are you ready to explore Manipur like never before?',
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primary, // Set the background color for the first button
                        borderRadius: BorderRadius.circular(20), // Adjust the border radius as needed
                      ),
                      child: OutlinedButton(
                        onPressed: () {
                          Get.to(Dashboard());
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Adjust the border radius as needed
                          ),
                          side: BorderSide.none, // Remove the border
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Text(
                            "GET STARTED",
                            style: TextStyle(
                              color: Colors.white, // Set text color to white
                              fontSize: 16, // Adjust the font size as needed
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15), // Add some space between the buttons
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.orangeWeb, // Set the background color for the first button
                        borderRadius: BorderRadius.circular(20), // Adjust the border radius as needed
                      ),
                      child: OutlinedButton(
                        onPressed: () { Get.to(Dashboard());},
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Adjust the border radius as needed
                          ),
                          side: BorderSide.none,
                          // Use primary color from the theme
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Text(
                            "I ALREADY HAVE AN ACCOUNT",
                            style: TextStyle(
                              color: AppColors.white, // Use primary color for the text
                              fontSize: 16, // Adjust the font size as needed
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )


              ],
            ),
          ),
        ));
  }
}
