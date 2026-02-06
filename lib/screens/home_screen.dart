//Home UI

import 'package:flutter/material.dart';
import '../model/habit.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>{
  final List<Habit> _habits = [
    Habit(
      title: 'Drink water',
      description: 'Drink at least 8 glasses of water',
      mood: Mood.happy,
    ),
    Habit(
      title: 'Exercise',
      description: '30 minutes of physical activity',
      mood: Mood.stressed,
    ),
    Habit(
      title: 'Study Flutter',
      description: 'Practice widgets and layouts',
      mood: Mood.neutral,
    ),
  ];

  Icon _getMoodIcon(Mood mood) {
    switch(mood){
      case Mood.happy:
        return const Icon(Icons.sentiment_satisfied,color: Colors.green);
      case Mood.stressed:
        return const Icon(Icons.sentiment_very_dissatisfied, color: Colors.red);
      case Mood.sad:
        return const Icon(Icons.sentiment_dissatisfied, color: Colors.blueGrey);
      case Mood.neutral:
      default:
        return const Icon(Icons.sentiment_neutral, color: Colors.orange);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("PulseTrack"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _habits.length,
        itemBuilder: (context,index){
          final habit = _habits[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: _getMoodIcon(habit.mood),
              title: Text(habit.title),
              subtitle: Text(habit.description),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //Add habit in next tasks
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}