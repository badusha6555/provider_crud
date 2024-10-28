import 'dart:io';

import 'package:flutter/material.dart';

class ViewProfile extends StatelessWidget {
  String name;
  int age;
  String cls;
  String phone;
  dynamic imagePath;
  ViewProfile(
      {required this.name,
      required this.age,
      required this.cls,
      required this.phone,
      required this.imagePath,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 148, 41, 41),
      appBar: AppBar(
        title: const Text('View Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 70,
                backgroundImage: imagePath != null
                    ? FileImage(File(imagePath))
                    : AssetImage("assets/spider.jpg")),
            const SizedBox(
              height: 20,
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              age.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              cls,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              phone,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
