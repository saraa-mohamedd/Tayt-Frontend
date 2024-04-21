// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:tayt_app/provider/outfit_provider.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/screens/user_screen/user_screen.dart';
import 'package:tuple/tuple.dart';
import '../screens/splash_screen/components/body.dart';
import '../screens/body_mesh_screen/body_mesh_screen.dart';
import '../screens/clothing_screen/clothing_screen.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/body_screen/body_screen.dart';
import '../screens/body_mesh_screen/components/body_mesh.dart';
import 'package:tayt_app/src/screens/tryon_screen/tryon_screen.dart';
import 'package:tayt_app/models/clothing_item.dart';
import 'package:tayt_app/models/outfit.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _MyBottomNavBarAppState createState() => _MyBottomNavBarAppState();
}

class _MyBottomNavBarAppState extends State<BottomNavBar> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Container(
          padding: EdgeInsets.symmetric(vertical: 0),
          child: Icon(
            Icons.home,
            size: 30,
          ),
        ),
        title: "Home",
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          padding: EdgeInsets.symmetric(vertical: 0),
          alignment: Alignment.center,
          child: Icon(
            //FontAwesomeIcons.shirt,
            Symbols.apparel,
            fill: 1,
            size: 27,
          ),
        ),
        title: "Clothing",
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: FaIcon(FontAwesomeIcons.personRays, size: 23),
        ),
        title: ("Try On"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: FaIcon(FontAwesomeIcons.solidUser, size: 23),
        ),
        title: ("Profile"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.black,
      ),
    ];
  }

  List<Widget> _screens() {
    // Replace these with your own screen widgets
    return [
      HomeScreen(),
      ClothingScreen(),
      TryOnScreen(
        outfit: Outfit(id: 2, items: [
          ClothingItem(
              id: 24,
              imagePath: 'assets/images/clothing/front24.jpeg',
              name: 'Clothing 24',
              description: 'Description 24',
              type: ClothingType.dress),
          ClothingItem(
              id: 25,
              imagePath: 'assets/images/clothing/front25.jpeg',
              name: 'Clothing 25',
              description: 'Description 25',
              type: ClothingType.dress)
        ]),
        numItems: 2,
      ),
      UserScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(context,
          navBarHeight: 52,
          decoration: NavBarDecoration(
            colorBehindNavBar: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          itemAnimationProperties: ItemAnimationProperties(
            duration: Duration(milliseconds: 150),
            curve: Curves.elasticIn,
          ),
          controller: _controller,
          screens: _screens(),
          items: _navBarItems(),
          navBarStyle: NavBarStyle.style12,
          screenTransitionAnimation: ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          )),
    );
  }
}
