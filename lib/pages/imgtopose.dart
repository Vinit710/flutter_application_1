import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'home.dart';
import 'genai.dart';
import 'profile.dart';
import 'AImagic.dart';
import 'login_page.dart';
import 'main_home.dart';
import 'setting.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MainHome(),
    ImageGenerationPage(),
    GenAIPage(),
    SettingsPage()// Assuming Settings is part of the ProfilePage
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
          child: IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      color: Color(0xFF1A1A2E),
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Container(
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                icon: Icon(Icons.home, color: _currentIndex == 0 ? Color(0xFF8A4FFF) : Colors.grey),
                onPressed: () => setState(() => _currentIndex = 0),
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.image, color: _currentIndex == 1 ? Color(0xFF8A4FFF) : Colors.grey),
                onPressed: () => setState(() => _currentIndex = 1),
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.brush, color: _currentIndex == 2 ? Color(0xFF8A4FFF) : Colors.grey),
                onPressed: () => setState(() => _currentIndex = 2),
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.settings, color: _currentIndex == 3 ? Color(0xFF8A4FFF) : Colors.grey),
                onPressed: () => setState(() => _currentIndex = 3),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
