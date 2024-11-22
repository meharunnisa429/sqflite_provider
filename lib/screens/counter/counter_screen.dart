import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/model/counter_model.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Provider Example")),
      body: Center(child: Consumer<CounterModel>(
          builder: (BuildContext context, CounterModel counter, Widget? _) {
        return Text("Count ${counter.count}");
      })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterModel>().incrementCounter(); // Increment count
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
