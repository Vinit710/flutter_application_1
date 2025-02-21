import 'package:flutter/material.dart';
// Your home page
import 'start.dart';

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C081E),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 72,
            ),
            const SizedBox(height: 24),
            const Text(
              'Disclaimer',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'poppins',
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'The models used in this app are freely available on Hugging Face. This app is intended solely for presenting these models in a user-friendly interface and is not intended for commercial purposes.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontFamily: 'poppins',
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                'https://huggingface.co/spaces';
              },
              child: const Text(
                'View Models on Hugging Face',
                style: TextStyle(
                  color: Color(0xFF8E37FE),
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => StartPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8E37FE),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Agree & Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
