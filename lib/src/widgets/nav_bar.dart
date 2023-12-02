// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tayt_app/src/screens/home_screen/home_screen.dart';
import 'package:tayt_app/src/screens/body_mesh_screen/body_mesh_screen.dart';
import 'package:tayt_app/src/screens/user_screen/user_screen.dart';
import 'package:tayt_app/src/screens/body_screen/body_screen.dart';
import 'package:tayt_app/src/screens/clothing_screen/clothing_screen.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    HomeScreen(),
    ClothingScreen(),
    BodyScreen(),
    UserScreen(),
  ];
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});
  static String routeName = '/nav-bar-screen';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          indicatorColor: Color(0x4d233d4d),
          height: 60,
          elevation: 0,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: controller.selectedIndex.value,
          shadowColor: Colors.black.withOpacity(0.5),
          onDestinationSelected: (index) => {
            controller.selectedIndex.value = index,
            print(controller.selectedIndex.value)
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home, size: 30),
              label: 'Home',
            ),
            NavigationDestination(
                icon: Icon(
                  Icons.shopping_bag,
                  size: 30,
                ),
                label: 'Clothing'),
            NavigationDestination(
              icon: FaIcon(
                FontAwesomeIcons.personRays,
                size: 25,
              ),
              label: 'My Body',
            ),
            NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.solidUser),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: Obx(
        () => controller.screens[controller.selectedIndex.value],
      ),
    );
  }
}
