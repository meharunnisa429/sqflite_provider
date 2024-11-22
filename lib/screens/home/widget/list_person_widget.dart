import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:provider_project/provider/person_controller.dart';

class ListPersonWidget extends StatefulWidget {
  const ListPersonWidget({super.key});

  @override
  State<ListPersonWidget> createState() => _ListPersonWidgetState();
}

class _ListPersonWidgetState extends State<ListPersonWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return // person list view
        Consumer<PersonController>(builder: (BuildContext context,
            PersonController personController, Widget? _) {
      return Expanded(
        child: ListView.separated(
          itemBuilder: (context, index) {
            final person = personController.personList[index];

            return Card(
              child: ListTile(
                title: Text("Name:- ${person.name}"),
                subtitle: Text("Age:- ${person.age}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // take data to update
                        context
                            .read<PersonController>()
                            .bringPersonToUpdate(person);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        // delete data
                        if (person.id != null) {
                          context
                              .read<PersonController>()
                              .deletePerson(person.id!);
                        }
                      },
                      color: Colors.red,
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: personController.personList.length,
        ),
      );
    });
  }
}
