import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_crud/controllers/image_provider.dart';

import 'package:pro_crud/controllers/student_provider.dart';
import 'package:pro_crud/model/student.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditStudent extends StatefulWidget {
  String? name;
  int? age;
  String? cls;
  String? phone;
  dynamic imagePath;
  int index;

  EditStudent({
    super.key,
    required this.name,
    required this.age,
    required this.cls,
    required this.phone,
    required this.imagePath,
    required this.index,
  });

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController clsController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void initState() {
    nameController.text = widget.name!;
    ageController.text = widget.age.toString();
    clsController.text = widget.cls!;
    phoneController.text = widget.phone!;
    Provider.of<PickImageProvider>(context, listen: false).image =
        widget.imagePath != null ? File(widget.imagePath) : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<StudentProvider>(context, listen: false).getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 70,
                  backgroundImage: Provider.of<PickImageProvider>(context,
                                  listen: false)
                              .image !=
                          null
                      ? FileImage(
                          Provider.of<PickImageProvider>(context, listen: false)
                              .image!)
                      : AssetImage("assets/spider.jpg") as ImageProvider),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<PickImageProvider>(context, listen: false)
                      .selectedImage(source: ImageSource.gallery);
                },
                child: const Text('Gallery'),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an age';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: clsController,
                      decoration: const InputDecoration(
                        labelText: 'Class',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a class';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() == true) {
                          onEditStudent();
                        }
                      },
                      child: Text("Edit Student"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onEditStudent() async {
    final editedName = nameController.text;
    final editedAge = int.parse(ageController.text);
    final editedCls = clsController.text;
    final editedPhone = phoneController.text;
    final editedImage =
        Provider.of<PickImageProvider>(context, listen: false).image!.path;
    final student = Student(
        name: editedName,
        age: editedAge,
        cls: editedCls,
        phone: editedPhone,
        imagePath: editedImage);
    Provider.of<StudentProvider>(context, listen: false)
        .editStudent(widget.index, student);
    Navigator.pop(context);
  }
}
