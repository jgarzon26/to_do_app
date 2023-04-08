import 'package:uuid/uuid.dart';

class Task {
  String id;
  String title;
  String description;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    this.isCompleted = false,
  }) : id = const Uuid().v4();

  @override
  bool operator ==(covariant Task other) {
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
