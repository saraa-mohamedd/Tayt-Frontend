import 'package:tayt_app/src/screens/body_mesh_screen/body_mesh_screen.dart';
import 'package:tayt_app/src/screens/splash_screen/splash_screen.dart';
import 'package:tayt_app/src/screens/home_screen/home_screen.dart';
import 'package:tayt_app/src/screens/body_screen/body_screen.dart';
import 'package:tayt_app/src/widgets/nav_bar.dart';
import 'package:flutter/cupertino.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  BodyScreen.routeName: (context) => const BodyScreen(),
  BottomNavBar.routeName: (context) => const BottomNavBar(),
  BodyMeshScreen.routeName: (context) => const BodyMeshScreen(),
};
