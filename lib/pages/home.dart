import 'package:flutter/material.dart';
import 'community.dart'; // Import CommunityPage
import 'settings.dart'; // Import SettingsPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<WidgetConfig> _widgetConfigs = [];

  @override
  void initState() {
    super.initState();
    // Initialize with some default widgets
    _widgetConfigs = [
      WidgetConfig(size: 100, color: Colors.blue, text: "Widget 1"),
      WidgetConfig(size: 120, color: Colors.green, text: "Widget 2"),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CommunityPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsPage()),
      );
    }
  }

  void _editWidget(int index) {
    final config = _widgetConfigs[index];
    showDialog(
      context: context,
      builder: (context) {
        double newSize = config.size;
        Color newColor = config.color;
        TextEditingController textController =
            TextEditingController(text: config.text);

        return AlertDialog(
          title: const Text("Edit Widget"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textController,
                decoration: const InputDecoration(labelText: "Text"),
              ),
              const SizedBox(height: 10),
              Slider(
                value: newSize,
                min: 50,
                max: 200,
                divisions: 10,
                label: "${newSize.round()}",
                onChanged: (value) {
                  setState(() {
                    newSize = value;
                  });
                },
              ),
              DropdownButton<Color>(
                value: newColor,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      newColor = value;
                    });
                  }
                },
                items: [
                  Colors.blue,
                  Colors.green,
                  Colors.red,
                  Colors.orange,
                  Colors.purple
                ]
                    .map((color) => DropdownMenuItem(
                          value: color,
                          child: Container(
                            width: 20,
                            height: 20,
                            color: color,
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _widgetConfigs[index] = WidgetConfig(
                    size: newSize,
                    color: newColor,
                    text: textController.text,
                  );
                });
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0xFF6C63FF),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: _widgetConfigs.length,
        itemBuilder: (context, index) {
          final config = _widgetConfigs[index];
          return GestureDetector(
            onTap: () => _editWidget(index),
            child: Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              height: config.size,
              color: config.color,
              alignment: Alignment.center,
              child: Text(
                config.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _widgetConfigs.add(
              WidgetConfig(
                size: 100,
                color: Colors.blue,
                text: "New Widget",
              ),
            );
          });
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFF4A47A3),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.8),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class WidgetConfig {
  double size;
  Color color;
  String text;

  WidgetConfig({
    required this.size,
    required this.color,
    required this.text,
  });
}
