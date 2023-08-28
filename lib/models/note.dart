import 'package:flutter/material.dart';

Map<int, dynamic> colors = {
  0: null,
  1: Colors.red,
  2: Colors.pink,
  3: Colors.purple,
  4: Colors.deepPurple,
  5: Colors.indigo,
  6: Colors.blue,
  7: Colors.lightBlue,
  8: Colors.cyan,
  9: Colors.teal,
  10: Colors.green,
  11: Colors.lightGreen,
  12: Colors.lime,
  13: Colors.yellow,
  14: Colors.amber,
  15: Colors.orange,
  16: Colors.deepOrange,
  17: Colors.brown,
  18: Colors.grey,
  19: Colors.blueGrey,
  20: Colors.black,
  21: Colors.white,
};

class Note {
  String id;
  String title;
  String description;
  DateTime date;
  bool isImportant;
  int colorIndex = 0;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isImportant = false,
    this.colorIndex = 0,
  });

  toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'isImportant': isImportant,
      'colorIndex': colorIndex,
    };
  }

  Note.fromMap(Map<dynamic, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        date = map['date'],
        isImportant = map['isImportant'],
        colorIndex = map['colorIndex'];

  @override
  String toString() {
    return 'Note{id: $id, title: $title, description: $description, date: $date, isImportant: $isImportant, colorIndex: $colorIndex}';
  }

  getColorForLight() {
    return colors[colorIndex].shade100;
  }

  getColorForDark() {
    return colors[colorIndex].shade300;
  }
}
