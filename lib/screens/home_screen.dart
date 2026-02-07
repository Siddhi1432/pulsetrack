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
  ];

  final TextEditingController _titleController = TextEditingController(); //read user input
  final TextEditingController _descriptionController = TextEditingController();

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

  void _showAddHabitSheet() {
    showModalBottomSheet(//displays input form
      context: context,
      isScrollControlled: true,//avoid keyboard overlap
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context){
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom+16,//handles soft keyboard
            top:16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  "Add new habit",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Habit Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _addHabit,
                  child: const Text("Add Habit"),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  void _addHabit() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if(title.isEmpty || description.isEmpty){
      return;
    }

    setState(() {//Tells Flutter: UI needs rebuild
      _habits.add(
        Habit(title: title, description: description),
      );
    });

    _titleController.clear();
    _descriptionController.clear();

    Navigator.pop(context);
  }

  int get _completedHabitsCount {
    return _habits.where((habit) => habit.isCompleted).length;
  }

  double get _progressValue {
    if(_habits.isEmpty) return 0;
    return _completedHabitsCount / _habits.length;
  }

  Widget _buildProgressSummary(){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Today’s Progress',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$_completedHabitsCount of ${_habits.length} habits completed',
            style: const TextStyle(color: Colors.white24),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: _progressValue,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("PulseTrack"),
      ),
      body: Column(
        children: [
          _buildProgressSummary(),
          Expanded(
            child: ListView.builder(
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
                    title: Text(
                      habit.title,
                      style: TextStyle(
                        decoration: habit.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: habit.isCompleted ? Colors.grey : null,
                      ),
                    ),
                    subtitle: Text(
                      habit.description,
                      style: TextStyle(
                        color: habit.isCompleted ? Colors.grey : null,
                      ),
                    ),
                    trailing: Checkbox(
                      value: habit.isCompleted,
                      onChanged: (value){
                        setState(() {
                          habit.isCompleted = value ?? false;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddHabitSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}