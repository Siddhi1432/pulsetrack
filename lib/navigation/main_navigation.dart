import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/stats_screen.dart';
import '../screens/settings_screen.dart';
import '../model/habit.dart';

class MainNavigation extends StatefulWidget{
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>{

  int _selectedIndex = 0;

  List<Habit> _habits = [];

  void _updateHabits(List<Habit> habits ){
    setState(() {
      _habits = habits;
    });
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens =[
      HomeScreen(
        habits: _habits,
        onHabitsChanged: _updateHabits,
      ),
      StatsScreen(habits: _habits),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: screens[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
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