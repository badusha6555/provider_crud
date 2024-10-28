import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pro_crud/model/student.dart';

class StudentProvider extends ChangeNotifier {
  List<Student> studentlist = [];
  List<Student> searchlist = [];
  List<Student> res = [];

  void addStudent(Student value) async {
    final studentDb = await Hive.openBox<Student>('student');
    studentDb.add(value);
    studentlist.add(value);
    notifyListeners();
    getAllStudents();
  }

  void getAllStudents() async {
    final studentDb = await Hive.openBox<Student>('student');
    studentlist.clear();
    studentlist.addAll(studentDb.values);
    notifyListeners();
  }

  void deleteStudent(index) async {
    final studentDb = await Hive.openBox<Student>('student');
    studentDb.deleteAt(index);
    getAllStudents();
    notifyListeners();
  }

  void editStudent(int index, Student value) async {
    final studentDb = await Hive.openBox<Student>('student');
    studentlist.clear();
    studentlist.addAll(studentDb.values);
    studentDb.putAt(index, value);
    getAllStudents();
    notifyListeners();
  }

  void loadStudents() {
    final allstudents = studentlist;
    searchlist = allstudents;
  }

  void searchStudent(String value) {
    if (value.isEmpty) {
      res = studentlist;
    } else {
      res = studentlist
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    searchlist = res;
    notifyListeners();
  }
}

  // void clearSearch() {
  //   searchlist.clear();
  //   notifyListeners();
  // }

