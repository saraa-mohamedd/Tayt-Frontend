import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayt_app/models/body_measurements.dart';
import 'package:tayt_app/provider/authentication_provider.dart';
import 'package:tayt_app/provider/body_provider.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/widgets/nav_bar.dart';

class FinalScreen extends StatefulWidget {
  final List<String> answers; // Example argument
  const FinalScreen({Key? key, required this.answers}) : super(key: key);

  @override
  _FinalScreenState createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
      });
    });
    printAnswers();
  }

  void printAnswers() {
    for (String answer in widget.answers) {
      print(answer);
    }
  }

  @override
  Widget build(BuildContext context) {
    final image = File(widget.answers[3]);
    final meshRenderer = Provider.of<BodyProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final userId = authProvider.getUserId();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff233d4d), Color(0xff2B4B5F)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 100,
                          backgroundColor: Colors.white,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '${(100).toInt()}%',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Account Created!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Image.asset(
                          'assets/icons/checkmark.png',
                          width: 140,
                          height: 140,
                          //padding underneath
                        ),
                      ),
                      Text(
                        'You can now view and edit your 3D body from the profile page.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    if (widget.answers[3] != "" || widget.answers[3] != null) {
                      //call hmr
                      meshRenderer.generateBodyMeshUsingHMR(userId, image);
                    } else {
                      Measurements measurements = Measurements(
                          waist: double.parse(widget.answers[6]),
                          hips: double.parse(widget.answers[5]),
                          chest: double.parse(widget.answers[4]),
                          height: double.parse(widget.answers[2]),
                          weight: double.parse(widget.answers[1]),
                          gender: widget.answers[0]);

                      //call mice
                      meshRenderer.generateBodyMeshUsingMeasurements(
                          measurements, userId);
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BottomNavBar(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(350, 40),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    backgroundColor: AppColors.secondaryColor.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadowColor: Colors.black.withOpacity(0.5),
                  ),
                  child: Text(
                    'Take Me Home',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
