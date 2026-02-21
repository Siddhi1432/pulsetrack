import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/stats_screen.dart';
import '../screens/settings_screen.dart';

class MainNavigation extends StatefulWidget{
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>{

  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    StatsScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: "Habits",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Stats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}