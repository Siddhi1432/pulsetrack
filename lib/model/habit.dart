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

}