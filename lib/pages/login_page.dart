import 'package:flutter/material.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: BackgroundPainter(),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.lock_outline,
                          size: 80,
                          color: Color(0xFF6C63FF),
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Sign in to continue',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        decoration: inputDecoration('Email'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: inputDecoration('Password'),
                        obscureText: true,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: Divider(
                                  color: Colors.white.withOpacity(0.5))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8)),
                            ),
                          ),
                          Expanded(
                              child: Divider(
                                  color: Colors.white.withOpacity(0.5))),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLogoButton('lib/images/google.png'),
                          const SizedBox(width: 20),
                          _buildLogoButton('lib/images/apple.png'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()),
                          );
                        },
                        child: Text(
                          'Don\'t have an account? Register',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoButton(String assetName) {
    return GestureDetector(
      onTap: () {
        // Handle logo button tap
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Image.asset(
          assetName,
          width: 30,
          height: 30,
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      prefixIcon: Icon(
        label == 'Email' ? Icons.email_outlined : Icons.lock_outline,
        color: const Color(0xFF6C63FF),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = const Color(0xFF4A47A3);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    paint.color = const Color(0xFF6C63FF).withOpacity(0.7);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.2), 100, paint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.8), 150, paint);

    paint.color = const Color(0xFF4A47A3).withOpacity(0.7);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.2), 80, paint);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.8), 120, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
