import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/database/model/person_model.dart';
import 'package:provider_project/model/save_edit_mode.dart';
import 'package:provider_project/provider/person_controller.dart';

class AddPersonWidget extends StatefulWidget {
  const AddPersonWidget(
      {super.key,
     });

  @override
  State<AddPersonWidget> createState() => _AddPersonWidgetState();
}

class _AddPersonWidgetState extends State<AddPersonWidget> {
  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  late final FocusNode _nameFocusNode;
  late final FocusNode _ageFocusNode;
  Person? _personToUpdate;
  SaveEditMode _saveEditMode = SaveEditMode.save;
@override
  void initState() {
    // TODO: implement initState
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _nameFocusNode = FocusNode();
    _ageFocusNode = FocusNode();
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _personToUpdate = context.watch<PersonController>().personToUpdate;
    _saveEditMode = context.watch<PersonController>().saveEditMode;
    // For updating
    if (_personToUpdate != null) {
      _nameController.text = _personToUpdate!.name;
      _ageController.text = _personToUpdate!.age.toString();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          focusNode: _nameFocusNode,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Name"),
            hintText: "Enter name",
            hintStyle: TextStyle(color: Colors.black38),
          ),
        ),

        const SizedBox(
          height: 8,
        ),
        // age textfield
        TextField(
          controller: _ageController,
          focusNode: _ageFocusNode,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Age"),
            hintText: "Enter age",
            hintStyle: TextStyle(color: Colors.black38),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(
          height: 8,
        ),

        // save or update button
        ElevatedButton(
          onPressed: () async {
            if (_saveEditMode == SaveEditMode.save) {
              // To save
              final personToSave = Person(
                name: _nameController.text.trim(),
                age: int.tryParse(_ageController.text.trim()) ?? 0,
              );
              await context.read<PersonController>().insertPerson(personToSave);
              _nameController.clear();
              _ageController.clear();
              _unFocusAllFocusNode();
            } else {
              // To update
              final personToUpdate = Person(
                id: _personToUpdate?.id,
                name: _nameController.text.trim(),
                age: int.tryParse(_ageController.text.trim()) ?? 0,
              );

              await context
                  .read<PersonController>()
                  .updatePerson(personToUpdate);
              _nameController.clear();
              _ageController.clear();
              _unFocusAllFocusNode();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                _saveEditMode == SaveEditMode.save ? Colors.green : Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: Text(_saveEditMode == SaveEditMode.save ? "Save" : "Update"),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  void _unFocusAllFocusNode() {
    _nameFocusNode.unfocus();
    _ageFocusNode.unfocus();
  }
}
