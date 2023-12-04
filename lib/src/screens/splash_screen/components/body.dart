import 'package:flutter/material.dart';
import 'package:tayt_app/src/screens/login_screen/login_screen.dart';
import 'package:tayt_app/src/deps/colors.dart';
// import 'package:tayt_app/src/widgets/nav_bar.dart';

class Body extends StatelessWidget {
  const Body({Key? key});

  void initState(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                LoginScreen(), // Replace with your desired screen
          ),
        );
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
          color: AppColors.secondaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
            ),
            Material(
              color: Colors.transparent,
            ),
            Text(
              'Tayt',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 90,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Ready to revolutionize your\nshopping experience?',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.primaryColor.withOpacity(0.8),
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
