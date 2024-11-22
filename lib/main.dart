import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/database/function/database_helper.dart';
import 'package:provider_project/model/counter_model.dart';
import 'package:provider_project/provider/person_controller.dart';
import 'package:provider_project/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initializing database
  await DatabaseHelper.initDatabase();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) {
          return CounterModel();
        },
      ),
      ChangeNotifierProvider(
        create: (context) {
          return PersonController();
        },
      )
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
      //  CounterScreen(),
    );
  }
}
