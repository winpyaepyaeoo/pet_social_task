import 'package:flutter/material.dart';
import 'package:flutter_animated_splash/flutter_animated_splash.dart';

import '../data/api/auth_service.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    saveUserToken();
  }

  void saveUserToken() async {
    String authToken =
        "10|iY4591ltqiN4UxuvFH2T06ZDrYQGfrBpqjPySzQG23a0bc6b"; // Replace with the actual token
    AuthService authService = AuthService();
    await authService.storeToken(authToken);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplash(
      type: Transition.size,
      durationInSeconds: 3,
      navigator: const HomeScreen(),
      child: Image.asset(
        "assets/images/pet_logo.png",
        height: 50,
      ),
    );
  }
}
