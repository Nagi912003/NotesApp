
import 'package:hive/hive.dart';
class Note {
  String id;
  String title;
  String description;
  DateTime date;
  bool isImportant;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isImportant = false,
  });

  toMap(){
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'isImportant': isImportant,
    };
  }

  Note.fromMap(Map<dynamic, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        date = map['date'],
        isImportant = map['isImportant'];

  @override
  String toString() {
    return 'Note{id: $id, title: $title, description: $description, date: $date, isImportant: $isImportant}';
  }

}