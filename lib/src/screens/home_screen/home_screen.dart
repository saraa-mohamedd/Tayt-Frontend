import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Color.fromARGB(255, 80, 27, 29),
        //   automaticallyImplyLeading: false,
        //   toolbarHeight: 70,
        //   elevation: 0,
        //   title: Center(
        //     child: Text(
        //       'Tayt',
        //       style: Theme.of(context).textTheme.displayLarge!.copyWith(
        //             textBaseline: TextBaseline.alphabetic,
        //             color: Colors.white.withOpacity(0.8),
        //             fontSize: 40,
        //             fontWeight: FontWeight.bold,
        //           ),
        //     ),
        //   ),
        //   bottom: PreferredSize(
        //     child: TabBar(
        //         isScrollable: true,
        //         unselectedLabelColor: Colors.white.withOpacity(0.3),
        //         indicatorColor: const Color(0xFF464646),
        //         tabs: [
        //           Tab(
        //             child: Text(
        //               'Option 1',
        //               style: Theme.of(context)
        //                   .textTheme
        //                   .headlineSmall!
        //                   .copyWith(
        //                       fontFamily: "GT Haptik",
        //                       color: Colors.white.withOpacity(0.8)),
        //             ),
        //           ),
        //           Tab(
        //             child: Text(
        //               'Option 2',
        //               style: Theme.of(context)
        //                   .textTheme
        //                   .headlineSmall!
        //                   .copyWith(
        //                       fontFamily: "GT Haptik",
        //                       color: Colors.white.withOpacity(0.8)),
        //             ),
        //           ),
        //           Tab(
        //             child: Text(
        //               'Option 3',
        //               style: Theme.of(context)
        //                   .textTheme
        //                   .headlineSmall!
        //                   .copyWith(
        //                       fontFamily: "GT Haptik",
        //                       color: Colors.white.withOpacity(0.8)),
        //             ),
        //           ),
        //         ]),
        //     preferredSize: Size.fromHeight(35),
        //   ),
        // ),
        appBar: AppBar(
          titleSpacing: 20,
          shadowColor: Colors.black.withOpacity(0.6),
          surfaceTintColor: Color(0xfffaf9f6),
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          title: Text(
            'Tayt',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                textBaseline: TextBaseline.alphabetic,
                color: Colors.black.withOpacity(0.9),
                fontSize: 36,
                fontWeight: FontWeight.values[7],
                letterSpacing: -0.7),
          ),
        ),
        drawer: SizedBox(width: 270),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Text(
                'Page 1',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Center(
              child: Text(
                'To be Built ',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            const Center(
              child: Text('under construction'),
            ),
          ],
        ),
        // bottomNavigationBar: CustomBottomNavBar(model: model),
      ),
    );
  }
}
