//Habit & Mood Model

enum Mood{ //fixed set of moods
  happy,
  neutral,
  stressed,
  sad,
}

class Habit {
  final String title; //immutable
  final String description;
  bool isCompleted; //habit tracking
  final Mood mood; //emotional state mapping

  Habit({
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.mood = Mood.neutral,
});

  //Storage can’t save objects → must convert to JSON.
  Map<String, dynamic> toJson(){
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'mood': mood.name,
    };
  }

  factory Habit.fromJson(Map<String, dynamic> json){
    return Habit(
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      mood: Mood.values.firstWhere(
          (m) => m.name == json['mood'],
      ),
    );
  }

}