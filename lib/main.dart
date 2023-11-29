import 'package:flutter/material.dart';
import 'package:tayt_app/routes/routes.dart';
// import 'package:tayt_app/service/navigation_service.dart';
import 'package:tayt_app/src/screens/splash_screen/splash_screen.dart';
// import 'package:tayt_app/provider/getit.dart';

void main() {
  // setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tayt',
      // navigatorKey: getIt<NavigationService>().navigatorKey,
      theme: ThemeData(
        fontFamily: 'Poppins',
        textSelectionTheme: const TextSelectionThemeData(
          // Set Up for TextFields
          cursorColor: Colors.grey,
          selectionColor: Colors.blueGrey,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: routes,
      home: const SplashScreen(),
    );
  }
}
