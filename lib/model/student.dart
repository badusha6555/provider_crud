import 'package:hive/hive.dart';
part 'student.g.dart';

@HiveType(typeId: 0)
class Student {
  @HiveField(0)
  String? name;
  @HiveField(1)
  int? age;
  @HiveField(2)
  String? cls;
  @HiveField(3)
  String? phone;
  @HiveField(4)
  String imagePath;

  Student({
    required this.name,
    required this.age,
    required this.cls,
    required this.phone,
    required this.imagePath,
  });
}
