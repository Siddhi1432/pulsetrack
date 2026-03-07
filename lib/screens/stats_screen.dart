import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../model/habit.dart';

class StatsScreen extends StatelessWidget{
  final List<Habit> habits;

  const StatsScreen({super.key, required this.habits});

  int get completedCount =>
  habits.where((h) => h.isCompleted).length;

  int get pendingCount =>
      habits.length - completedCount;

  @override
  Widget build(BuildContext context) {
    if(habits.isEmpty){
      return const Center(child: Text("No data yet"));
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Habits Statistics",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 250,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: completedCount.toDouble(),
                    title: "Completed",
                    color: Colors.green,
                  ),
                  PieChartSectionData(
                    value: pendingCount.toDouble(),
                    title: "Pending",
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text("Total Habits: ${habits.length}"),
          Text("Completed: $completedCount"),
          Text("Pending: $pendingCount"),
        ],
      ),
    );
  }
}