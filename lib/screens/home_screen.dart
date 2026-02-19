//Home UI

import 'package:flutter/material.dart';
import '../model/habit.dart';
import '../services/habit_storage.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>{

  Habit? _editingHabit;
  int? _editingIndex;

  Mood _selectedMood = Mood.neutral;

  List<Habit> _habits = [];

//Load Habits When App Starts
  @override
  void initState(){
    super.initState();
    _loadHabits();
  }

  void _loadHabits() async{
    final habits = await HabitStorage.loadHabits();
    setState(() {
      _habits = habits;
    });
  }

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
              Text(
                  _editingHabit == null ? "Add New Habit" : "Edit Habit",
                style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
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
              const Text(
                'Select Mood',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              Wrap(
                spacing: 12,
                children: Mood.values.map((mood){
                  return ChoiceChip(
                    label: Text(mood.name),
                    selected: _selectedMood == mood,
                    onSelected: (selected){
                      setState(() {
                        _selectedMood = mood;
                      });
                    },
                  );
                }).toList(),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveHabit,
                  child: Text(_editingHabit == null ? "Add Habit" : "Update Habit"),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  void _saveHabit() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if(title.isEmpty || description.isEmpty){
      return;
    }

    setState(() {
      if(_editingHabit == null){
        // ADD MODE
        _habits.add(
          Habit(
            title: title,
            description: description,
            mood: _selectedMood,
          ),
        );
      } else {
        // EDIT MODE
        _habits[_editingIndex!] = Habit(
            title: title,
            description: description,
            isCompleted: _editingHabit!.isCompleted,
            mood: _selectedMood,
        );
      }
    });
    HabitStorage.saveHabits(_habits);

    _titleController.clear();
    _descriptionController.clear();
    _selectedMood = Mood.neutral;
    _editingHabit = null;
    _editingIndex = null;

    Navigator.pop(context);
  }

  int get _completedHabitsCount {
    return _habits.where((habit) => habit.isCompleted).length;
  }

  double get _progressValue {
    if(_habits.isEmpty) return 0;
    return _completedHabitsCount / _habits.length;
  }

  void _openEditHabit(int index) {
    final habit = _habits[index];

    _titleController.text = habit.title;
    _descriptionController.text = habit.description;
    _selectedMood = habit.mood;

    _editingHabit = habit;
    _editingIndex = index;

    _showAddHabitSheet();
  }

  Future<bool?> _showDeleteConformation(){
    return showDialog<bool>(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text("Delete Habit"),
          content: const Text("Are you sure you want to delete this habit?"),
          actions: [
            TextButton(
              onPressed: ()=> Navigator.pop(context,false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: ()=> Navigator.pop(context,true),
              child: const Text("Delete"),
            )
          ],
        );
      }
    );
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

                return Dismissible(
                  key: ValueKey(habit.title + habit.description),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),

                  confirmDismiss: (direction) async{
                    return await _showDeleteConformation();
                  },

                  onDismissed: (direction){
                    final removedHabit = habit;

                    setState(() {
                      _habits.remove(removedHabit);
                    });
                    HabitStorage.saveHabits(_habits);
                  },

                  child: Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      onTap: (){
                        _openEditHabit(index);
                      },
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