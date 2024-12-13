import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';


class HomePage1 extends StatelessWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF0F4F8),
              Color(0xFFE6E6FA),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'InstantID',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6A5ACD),
                      ),
                    ),
                    Icon(
                      Icons.science_rounded,
                      color: Color(0xFF6A5ACD),
                      size: 30,
                    ),
                  ],
                ),

                SizedBox(height: 40),

                // Main Content
                Text(
                  'Transform Your Photos\nwith AI Magic',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),

                SizedBox(height: 16),

                Text(
                  'Blend faces and poses seamlessly using cutting-edge AI technology. Upload a face and a pose, and watch as our advanced algorithms create stunning, unique images in seconds.',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 32),

                // Features
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFeatureCard(
                      icon: Icons.face,
                      label: 'Face Swap',
                    ),
                    _buildFeatureCard(
                      icon: Icons.camera_alt,
                      label: 'Pose Transfer',
                    ),
                    _buildFeatureCard(
                      icon: Icons.auto_fix_high,
                      label: 'AI Magic',
                    ),
                  ],
                ),

                Spacer(),

                // Try Now Button
                Center(
  child: ElevatedButton(
    onPressed: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF6A5ACD),
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
    ),
    child: Text(
      'Try Now',
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),

                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({required IconData icon, required String label}) {
    return Container(
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Color(0xFF6A5ACD),
            size: 40,
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}