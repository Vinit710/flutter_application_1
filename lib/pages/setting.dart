import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C081E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Developers',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildDeveloperCard(
              'Vinit AKA Venom',
              'vinitdesai@4933@gmail.com',
              Icons.person,
            ),
            const SizedBox(height: 12),
            _buildDeveloperCard(
              'Shivam AKA Dead Shadøw',
              'shivam12119r@gmail.com',
              Icons.person,
            ),
            const SizedBox(height: 32),
            
            const Text(
              'Support',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingsItem(
              'FAQs',
              Icons.help_outline,
              () {},
            ),
            _buildSettingsItem(
              'Report a Bug',
              Icons.bug_report_outlined,
              () {},
            ),
            _buildSettingsItem(
              'Contact Us',
              Icons.email_outlined,
              () {},
            ),
            const SizedBox(height: 32),
            
            const Text(
              'Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingsItem(
              'Log Out',
              Icons.logout,
              () => _signOut(context),
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeveloperCard(String name, String email, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(141, 55, 254, 0.4),
            Color.fromRGBO(254, 55, 224, 0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFF8E37FE),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                email,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontFamily: 'poppins',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(String title, IconData icon, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : const Color(0xFF8E37FE),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : Colors.white,
          fontFamily: 'poppins',
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.white54,
      ),
    );
  }
}