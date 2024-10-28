import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:pro_crud/controllers/image_provider.dart';
import 'package:pro_crud/controllers/student_provider.dart';
import 'package:pro_crud/model/student.dart';
import 'package:pro_crud/view/home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentProvider()),
        ChangeNotifierProvider(create: (context) => PickImageProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Home()),
    );
  }
}
