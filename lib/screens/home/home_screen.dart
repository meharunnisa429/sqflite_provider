import 'package:flutter/material.dart';

import 'package:provider_project/screens/home/widget/add_person_widget.dart';
import 'package:provider_project/screens/home/widget/list_person_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Sqflite With Provider"),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[AddPersonWidget(), ListPersonWidget()],
          ),
        ),
      ),
    );
  }
}
