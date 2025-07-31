import 'package:flutter/material.dart';
import '../widgets/Bottom_Nav_Bar.dart';
import 'home_screen.dart';
import 'Profile_Screen.dart';
import 'signup.screen.dart';
import 'welcome.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Add a delay of 3 seconds (3000 milliseconds) before navigating to the next screen
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to the next screen (replace `NextScreen` with the actual screen you want to navigate to)
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );
    });

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF23272E),
        image: DecorationImage(
          image: AssetImage("assets/patern.png"), // Set your background image here
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.7),
            BlendMode.srcATop,
          ),
        ),
      ),
      child: Center(
        child: Container(
          width: 200, // Adjust the width as needed
          height: 200, // Adjust the height as needed
          child: Image.asset("assets/aa.png"),
        ),
      ),
    );
  }
}
