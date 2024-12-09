import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0xFF6C63FF),
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Home Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: const Color(0xFF4A47A3),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.8),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: List.generate(
            3,
            (index) => _buildBubbleItem(
              icon: _getIconForIndex(index),
              label: _getLabelForIndex(index),
              isActive: index == _selectedIndex,
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBubbleItem({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.all(isActive ? 8 : 0),
        decoration: isActive
            ? const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              )
            : null,
        child: Icon(
          icon,
          size: isActive ? 30 : 24,
          color: isActive ? const Color(0xFF6C63FF) : Colors.white,
        ),
      ),
      label: label,
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.group;
      case 2:
        return Icons.settings;
      default:
        return Icons.circle;
    }
  }

  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Community';
      case 2:
        return 'Settings';
      default:
        return '';
    }
  }
}
