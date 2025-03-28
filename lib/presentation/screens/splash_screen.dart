import 'package:flutter/material.dart';
import 'package:timenest/presentation/screens/home/home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Track Improve Succeed',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreenMain(),
    );
  }
}

class SplashScreenMain extends StatelessWidget {
  const SplashScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the custom colors
    const backgroundColor = Color.fromARGB(
      255,
      237,
      232,
      220,
    ); // Beige/cream background
    const accentColor = Color.fromARGB(
      255,
      165,
      182,
      141,
    ); // Light green accent color

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 172,
                height: 172,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      'assets/icon/timenest_icon.jpg',
                      width: 172,
                      height: 172,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              const SizedBox(height: 40),

              // "Track" text
              const Text(
                "Track",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins",
                  color: Colors.black,
                ),
              ),

              // "Improve" text
              const Text(
                "Improve",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              // "Succeed" text
              const Text(
                "Succeed",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                  color: accentColor,
                ),
              ),

              const SizedBox(height: 60),

              // "GET STARTED" button
              ElevatedButton(
                onPressed: () {
                  // Add navigation to the next screen here
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(280, 64),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "GET STARTED",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: backgroundColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
