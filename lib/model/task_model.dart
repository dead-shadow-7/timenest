import 'package:hive/hive.dart';

part 'task_model.g.dart'; // For Hive-generated code

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String option;

  Task({
    required this.name,
    required this.description,
    required this.date,
    required this.option,
  });
}
