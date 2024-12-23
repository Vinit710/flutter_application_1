import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_page.dart';
import 'imgtopose.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  Future<void> _loginWithEmailPassword() async {
    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage1()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(switch (e.code) {
              'user-not-found' => 'No user found with this email',
              'wrong-password' => 'Invalid password',
              'invalid-email' => 'Invalid email format',
              'user-disabled' => 'This account has been disabled',
              _ => 'Login failed: ${e.message}',
            }),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage1()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google Sign-In failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C081E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 148,
                height: 148,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromRGBO(234, 55, 228, 0.6),
                    width: 4,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(165, 185, 255, 0.3),
                      blurRadius: 256,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_fix_high,
                  color: Colors.white,
                  size: 72,
                ),
              ),
              const SizedBox(height: 32),

              const Text(
                'Welcome Back !',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'poppins',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),

              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(141, 55, 254, 0.4),
                      Color.fromRGBO(254, 55, 224, 0.4),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'poppins',
                  ),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontFamily: 'poppins'),
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
              ),
              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(141, 55, 254, 0.4),
                      Color.fromRGBO(254, 55, 224, 0.4),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontFamily: 'poppins'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(165, 185, 255, 0.4),
                      blurRadius: 192,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _loginWithEmailPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8E37FE),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(child: Divider(color: Colors.white.withOpacity(0.3))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'or continue with',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: 'poppins'
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.white.withOpacity(0.3))),
                ],
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _signInWithGoogle,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Image.asset(
                        'lib/images/google.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Image.asset(
                      'lib/images/apple.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontFamily: 'poppins'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        color: Color(0xFF8E37FE),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

