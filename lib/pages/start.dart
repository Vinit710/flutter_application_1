import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E), // Dark background color
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            // Image container with rounded corners and shadow
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 36),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x99FF0E16),
                    blurRadius: 196,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(36),
                child: Stack(
                  children: [
                    // Red gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            Colors.red.withOpacity(0.3),
                            Colors.transparent
                          ],
                          stops: const [0.2, 1.0],
                          radius: 0.8,
                        ),
                      ),
                    ),
                    Image.asset(
                      'lib/images/astro.png', // Make sure to add this image to your assets
                      fit: BoxFit.cover,
                      height: 412,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),
            // Text section
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Where ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 32,
                      fontWeight: FontWeight.normal, // Regular weight
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: 'Creativity',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 32,
                      fontWeight: FontWeight.bold, // Bold weight
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const Text(
              'Meets',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 32,
                color: Colors.white,
              ),
            ),
            const Text(
              'Imagination.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            // Get Started Button
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(165, 185, 255, 0.2),
                    blurRadius: 128,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 52, vertical: 32),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8E37FE), // Purple color
                    minimumSize: const Size(double.infinity, 62),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.wandMagicSparkles,
                          color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
