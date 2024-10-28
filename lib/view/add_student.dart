import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_crud/controllers/image_provider.dart';
import 'package:pro_crud/controllers/student_provider.dart';
import 'package:pro_crud/model/student.dart';
import 'package:provider/provider.dart';

class AddStudent extends StatefulWidget {
  AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final nameController = TextEditingController();

  final ageController = TextEditingController();

  final clsController = TextEditingController();

  final phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Provider.of<StudentProvider>(context).getAllStudents();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 148, 41, 41),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Pro Crud',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                          radius: 70,
                          backgroundImage: Provider.of<PickImageProvider>(
                                          context,
                                          listen: false)
                                      .image !=
                                  null
                              ? FileImage(Provider.of<PickImageProvider>(
                                      context,
                                      listen: false)
                                  .image!)
                              : AssetImage("assets/spider.jpg")),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Provider.of<PickImageProvider>(context, listen: false)
                              .selectedImage(source: ImageSource.gallery);
                        },
                        child: const Text('Gallery'),
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter your name',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Age',
                          hintText: 'Enter your age',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an age';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: clsController,
                        decoration: const InputDecoration(
                          labelText: 'Class',
                          hintText: 'Enter your class',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a class';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          hintText: 'Enter your phone number',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            onAddBtn();
                          }
                        },
                        child: const Text('Add Student'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onAddBtn() async {
    final name = nameController.text.trim();
    final age = int.parse(ageController.text.trim());
    final cls = clsController.text.trim();
    final phone = phoneController.text.trim();

    final student = Student(
        name: name,
        age: age,
        cls: cls,
        phone: phone,
        imagePath:
            Provider.of<PickImageProvider>(context, listen: false).image!.path);
    Provider.of<StudentProvider>(context, listen: false).addStudent(student);
    nameController.clear();
    ageController.clear();
    clsController.clear();
    phoneController.clear();
    Provider.of<PickImageProvider>(context, listen: false).image = null;
    Navigator.pop(context);
    log(student.name!);
  }
}
