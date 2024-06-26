import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:tayt_app/provider/authentication_provider.dart';
import 'package:tayt_app/provider/body_provider.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tayt_app/src/screens/body_mesh_screen/body_mesh_screen.dart';

import 'package:tayt_app/src/screens/body_screen/components/form.dart';
import 'package:tayt_app/src/screens/body_screen/components/hmrform.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tayt App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection); // Add listener
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the controller
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      // Force rebuild when tab changes
    });
  }

  @override
  Widget build(BuildContext context) {
    final meshRenderer = Provider.of<BodyProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final userId = authProvider.getUserId();
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child: Text(
                    'Help us understand you better!\n\nEnter your measurements below, or upload \na picture of yourself in a tight fitting outfit.',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.black,
                          fontFamily: 'Helvetica Neue',
                          fontSize: 16,
                          height: 1.2,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            // Add a tab controller
            Container(
              child: TabBar(
                controller: _tabController,
                onTap: (index) {
                  _tabController.animateTo(index); // Switch to the tapped tab
                },
                //change the color of the selected tab
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: Colors.black,
                labelStyle:
                    TextStyle(fontSize: 14, fontFamily: 'Helvetica Neue'),
                indicatorColor: AppColors.primaryColor,
                // indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.all(0),

                tabs: [
                  Tab(
                    //icon: Icon(Icons.person),
                    icon: FaIcon(FontAwesomeIcons.ruler, size: 20),
                    text: 'Measurements',
                  ),
                  Tab(
                    icon: Icon(Icons.camera_alt, size: 20),
                    text: 'Upload Picture',
                  ),
                ],
              ),
            ),
            //tabbar view
            Container(
              height: MediaQuery.of(context).size.height * 0.60,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: MeasurementsForm(),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3d000000),
                                  blurRadius: 10,
                                  offset: Offset(5, 5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.45,
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: HMRForm(),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3d000000),
                                  blurRadius: 10,
                                  offset: Offset(5, 5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
