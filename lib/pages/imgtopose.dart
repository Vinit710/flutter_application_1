import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'home.dart';
import 'genai.dart';
import 'profile.dart';
import 'AImagic.dart';
import 'login_page.dart';

class GlowingText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const GlowingText({Key? key, required this.text, required this.style}) : super(key: key);

  @override
  _GlowingTextState createState() => _GlowingTextState();
}

class _GlowingTextState extends State<GlowingText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _opacityAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.text.length * 200),
    );

    _opacityAnimations = List.generate(
      widget.text.length,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index / widget.text.length, (index + 1) / widget.text.length, curve: Curves.easeInOut),
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            widget.text.length,
            (index) => _buildGlowingLetter(index),
          ),
        );
      },
    );
  }

  Widget _buildGlowingLetter(int index) {
    return AnimatedBuilder(
      animation: _opacityAnimations[index],
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(_opacityAnimations[index].value * 0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Text(
            widget.text[index],
            style: widget.style.copyWith(
              color: Colors.white.withOpacity(_opacityAnimations[index].value),
            ),
          ),
        );
      },
    );
  }
}

class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeroSection(),
                        SizedBox(height: 32),
                        _buildFeatures(),
                        SizedBox(height: 32),
                        _buildRecentWorks(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildAppBar() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'InstantID',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                // TODO: Implement notifications
              },
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.account_circle, color: Colors.white),
              onSelected: (value) {
                if (value == 'Edit Profile') {
                  _navigateToProfile();
                } else if (value == 'Log Out') {
                  _logout();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'Edit Profile',
                  child: Text('Edit Profile'),
                ),
                PopupMenuItem(
                  value: 'Log Out',
                  child: Text('Log Out'),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

// Navigate to the Profile page
void _navigateToProfile() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ProfilePage()),
  );
}

// Logout function
void _logout() {
  // Clear user session data (if any)
  // For example: SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.clear();

  // Navigate to the login page
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
}

  Widget _buildHeroSection() {
    return AnimationConfiguration.synchronized(
      duration: const Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
  text: TextSpan(
    style: GoogleFonts.poppins(
      fontSize: 40,
      fontWeight: FontWeight.w800,
      color: Colors.white,
      height: 1.2,
    ),
    children: [
      TextSpan(text: 'Imagine And\n'),
      TextSpan(text: 'Create'),
    ],
  ),
),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImageGenerationPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8A4FFF),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Features',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        AnimationConfiguration.synchronized(
          duration: const Duration(milliseconds: 500),
          child: SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFeatureCard(
                    icon: Icons.face,
                    label: 'GenAI',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GenAIPage())),
                  ),
                  _buildFeatureCard(
                    icon: Icons.camera_alt,
                    label: 'Pose Transfer',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ImageGenerationPage())),
                  ),
                  _buildFeatureCard(
                    icon: Icons.auto_fix_high,
                    label: 'AI Magic',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AIMagicPage())),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Color(0xFF0F3460).withOpacity(0.2),
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
              color: Colors.white,
              size: 40,
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentWorks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Works',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        AnimationConfiguration.synchronized(
          duration: const Duration(milliseconds: 500),
          child: SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(
              child: Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 150,
                      margin: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage('https://picsum.photos/200/300?random=$index'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: _currentIndex == 0 ? Color(0xFF8A4FFF) : Colors.grey),
              onPressed: () => setState(() => _currentIndex = 0),
            ),
            IconButton(
              icon: Icon(Icons.search, color: _currentIndex == 1 ? Color(0xFF8A4FFF) : Colors.grey),
              onPressed: () => setState(() => _currentIndex = 1),
            ),
            SizedBox(width: 40), // Placeholder for FAB
            IconButton(
              icon: Icon(Icons.favorite, color: _currentIndex == 2 ? Color(0xFF8A4FFF) : Colors.grey),
              onPressed: () => setState(() => _currentIndex = 2),
            ),
            IconButton(
              icon: Icon(Icons.person, color: _currentIndex == 3 ? Color(0xFF8A4FFF) : Colors.grey),
              onPressed: () => setState(() => _currentIndex = 3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add_a_photo),
      onPressed: () {
        // TODO: Implement photo upload
      },
      backgroundColor: Color(0xFF8A4FFF),
    );
  }
}

