import 'package:hive/hive.dart';
import 'package:todo_app/domain/entities/local/task_entity.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  static const String boxKey = 'task';
  @HiveField(1)
  String? id;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? description;
  @HiveField(4)
  DateTime? createdDate;
  @HiveField(5)
  String? image;
  @HiveField(6)
  String? status;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.createdDate,
    this.image,
    this.status,
  });

  TaskEntity toEntity() => TaskEntity(
      id: id,
      title: title,
      description: description,
      createdDate: createdDate,
      image: image,
      status: status);
}
