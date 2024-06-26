import 'package:flutter/material.dart';
import 'package:tayt_app/provider/authentication_provider.dart';
import 'package:tayt_app/provider/collision_provider.dart';
import 'package:tayt_app/provider/favorites_provider.dart';
import 'package:tayt_app/provider/body_provider.dart';
import 'package:tayt_app/provider/home_provider.dart';
import 'package:tayt_app/provider/outfit_provider.dart';
import 'package:tayt_app/provider/clothing_provider.dart';
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
    // Create providers for the api calls
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OutfitProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ClothingProvider()),
        ChangeNotifierProvider(create: (_) => BodyProvider()),
        ChangeNotifierProvider(create: (_) => CollisionsProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider())
      ],
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
