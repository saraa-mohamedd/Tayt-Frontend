import 'package:flutter/material.dart';
import 'package:tayt_app/provider/outfit_provider.dart';
import 'package:tayt_app/routes/routes.dart';
import 'package:tayt_app/service/navigation_service.dart';
import 'package:tayt_app/src/screens/splash_screen/splash_screen.dart';
import 'package:tayt_app/provider/getit.dart';
import 'package:provider/provider.dart';
import 'package:tayt_app/src/widgets/nav_bar.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OutfitProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tayt',
        navigatorKey: getIt<NavigationService>().navigatorKey,
        theme: ThemeData(
          fontFamily: 'Poppins',
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.grey,
            selectionColor: Colors.blueGrey,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: routes,
        home: SplashScreen(),
      ),
    );
  }
}
