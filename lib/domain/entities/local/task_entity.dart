import 'package:todo_app/data/models/local/task_model.dart';

class TaskEntity {
  String? id;
  String? title;
  String? description;
  DateTime? createdDate;
  String? image;
  String? status;

  TaskEntity({
    this.id,
    this.title,
    this.description,
    this.createdDate,
    this.image,
    this.status,
  });

  TaskModel toModel() => TaskModel(
      id: id,
      title: title,
      description: description,
      createdDate: createdDate,
      image: image,
      status: status);
}
