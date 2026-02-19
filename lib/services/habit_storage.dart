//Storage Helper File

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/habit.dart';

class HabitStorage {
  static const String key = 'habits';

  static Future<void> saveHabits(List<Habit> habits) async{
    final prefs = await SharedPreferences.getInstance();

    final habitList =
        habits.map((habit) => jsonEncode(habit.toJson())).toList();
    
    await prefs.setStringList(key, habitList);
  }

  static Future<List<Habit>> loadHabits() async{
    final prefs = await SharedPreferences.getInstance();
    final habitList = prefs.getStringList(key);

    if(habitList == null) return [];

    return habitList
        .map((habit) => Habit.fromJson(jsonDecode(habit)))
        .toList();
  }
}