import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pro_crud/controllers/student_provider.dart';
import 'package:pro_crud/view/add_student.dart';
import 'package:pro_crud/view/edit_student.dart';
import 'package:pro_crud/view/view_profile.dart';
import 'package:provider/provider.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    Provider.of<StudentProvider>(context, listen: false).loadStudents();
    Provider.of<StudentProvider>(context, listen: false).getAllStudents();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 148, 41, 41),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddStudent()));
              },
              icon: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 255, 245, 245),
              ))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: "Search here",
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 148, 41, 41),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.white),
                onChanged: (value) {
                  Provider.of<StudentProvider>(context, listen: false)
                      .searchStudent(value);
                },
              ),
            ),
            const Text(
              'Student List',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Consumer<StudentProvider>(
                builder: (context, studentProvider, child) {
                  return ListView.separated(
                    itemCount: studentProvider.searchlist.length,
                    itemBuilder: (context, index) {
                      final data = studentProvider.searchlist[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewProfile(
                                        name: data.name!,
                                        age: data.age!,
                                        cls: data.cls!,
                                        phone: data.phone!,
                                        imagePath: data.imagePath,
                                      )));
                        },
                        title: Text(data.name!),
                        subtitle: Text(data.age.toString()),
                        leading: CircleAvatar(
                            backgroundImage: data.imagePath != null
                                ? FileImage(File(data.imagePath))
                                : AssetImage("assets/spider.jpg")
                                    as ImageProvider),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditStudent(
                                          name: data.name,
                                          age: data.age,
                                          cls: data.cls,
                                          phone: data.phone,
                                          imagePath: data.imagePath,
                                          index: index),
                                    ));
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                studentProvider.deleteStudent(index);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        thickness: 5,
                        color: Colors.black,
                        height: 3,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
