import 'package:flutter/material.dart';

class ClothingTabs extends StatefulWidget {
  const ClothingTabs({Key? key}) : super(key: key);

  @override
  State<ClothingTabs> createState() => _ClothingTabsState();
}

class _ClothingTabsState extends State<ClothingTabs>
    with SingleTickerProviderStateMixin {
  // const ClothingTabs({Key? key}) : super(key: key);
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.directions_bike),
                ),
                Tab(
                  icon: Icon(
                    Icons.directions_car,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            children: [
              // first tab bar view widget
              Container(
                color: Colors.red,
                child: Center(
                  child: Text(
                    'Bike',
                  ),
                ),
              ),

              // second tab bar viiew widget
              Container(
                color: Colors.pink,
                child: Center(
                  child: Text(
                    'Car',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
