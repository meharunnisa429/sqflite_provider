import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider_project/database/function/database_helper.dart';
import 'package:provider_project/database/model/person_model.dart';
import 'package:provider_project/model/save_edit_mode.dart';

class PersonController extends ChangeNotifier {
  PersonController() {
    getAllPerson();
  }
  List<Person> _personItems = [];

  UnmodifiableListView<Person> get personList =>
      UnmodifiableListView(_personItems);

  Person? _personToUpdate;
  Person? get personToUpdate => _personToUpdate;
  SaveEditMode _saveEditMode = SaveEditMode.save;
  SaveEditMode get saveEditMode => _saveEditMode;

  Future<void> insertPerson(Person person) async {
    await DatabaseHelper.insertPerson(person);
    await getAllPerson();
  }

  Future<void> getAllPerson() async {
    _personItems = await DatabaseHelper.getAllPersons();
    notifyListeners();
  }

  void bringPersonToUpdate(Person person) {
    _personToUpdate = person;
    _saveEditMode = SaveEditMode.edit;
    notifyListeners();
  }

  Future<void> updatePerson(Person person) async {
    await DatabaseHelper.updatePerson(person);
    _saveEditMode = SaveEditMode.save;
    _personToUpdate = null;
    await getAllPerson();
  }

  Future<void> deletePerson(int id) async {
    await DatabaseHelper.deletePerson(id);
    await getAllPerson();
  }

  @override
  void dispose() {
    DatabaseHelper.closeDatabase();
    super.dispose();
  }
}
