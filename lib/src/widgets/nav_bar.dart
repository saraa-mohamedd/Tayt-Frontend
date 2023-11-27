// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tayt_app/src/screens/home_screen/home_screen.dart';
import 'package:tayt_app/src/screens/body_mesh_screen/body_mesh_screen.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    HomeScreen(),
    Container(color: const Color.fromRGBO(33, 150, 243, 1)),
    BodyMeshScreen(),
    Container(color: Colors.yellow),
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
          indicatorColor: Color.fromARGB(122, 236, 209, 111),
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
