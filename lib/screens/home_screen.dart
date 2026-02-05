import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PulseTrack"),
      ),
      body: Center(
        child: Text(
          "Welcome to PulseTrack",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //will add habit/mood later
        },
        child: const Icon(Icons.add),
      ),
    );
  }

}