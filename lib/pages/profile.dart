import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  final _usernameController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Initialize with current user's email
    _usernameController.text = _auth.currentUser?.displayName ?? '';
  }

  // Function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: const Color(0xFF8E37FE),
              onPrimary: Colors.white,
              surface: const Color(0xFF0C081E),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF0C081E),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Function to sign out
  Future<void> _signOut() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF0C081E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Avatar with Gradient Border
              Container(
                width: 148,
                height: 148,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromRGBO(234, 55, 228, 0.6),
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(165, 185, 255, 0.3),
                      blurRadius: 256,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 72,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // User Email Display
              Text(
                user?.email ?? 'No email',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'poppins',
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 32),

              // Username Input
              _buildProfileField(
                controller: _usernameController,
                hintText: 'Username',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),

              // Date of Birth Selection
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromRGBO(141, 55, 254, 0.4),
                        const Color.fromRGBO(254, 55, 224, 0.4),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.cake_outlined,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    title: Text(
                      _selectedDate == null
                          ? 'Select Date of Birth'
                          : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                      style: TextStyle(
                        color: _selectedDate == null 
                          ? Colors.white.withOpacity(0.5)
                          : Colors.white,
                        fontFamily: 'poppins',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Save Profile Button
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(165, 185, 255, 0.4),
                      blurRadius: 192,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement profile save logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile Updated'),
                        backgroundColor: Color(0xFF8E37FE),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8E37FE),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Save Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Sign Out Button
              TextButton(
                onPressed: _signOut,
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontFamily: 'poppins',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to create consistent profile input fields
  Widget _buildProfileField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromRGBO(141, 55, 254, 0.4),
            const Color.fromRGBO(254, 55, 224, 0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'poppins',
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontFamily: 'poppins',
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}