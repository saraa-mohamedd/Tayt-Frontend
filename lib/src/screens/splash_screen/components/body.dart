import 'package:flutter/material.dart';
import 'package:tayt_app/src/widgets/nav_bar.dart';

class Body extends StatelessWidget {
  const Body({Key? key});

  void initState(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        // Get.to(() => const BottomNavBar());
        Navigator.of(context).pushReplacementNamed(BottomNavBar.routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    initState(context); // Call initState with the context
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 40,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_screen_bg.jpg'),
            fit: BoxFit.cover,
          ),
          // color: Color.fromARGB(255, 100, 72, 92),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
            ),
            Material(
              // child: Image.asset('assets/images/splash_img.png'),
              color: Colors.transparent,
            ),
            Text(
              'Tayt',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 90,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Ready to revolutionize your\nshopping experience?',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: const Color(0xFFBDBDBD),
                      fontFamily: 'Helvetica Neue',
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
