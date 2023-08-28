import 'package:hive_flutter/hive_flutter.dart';

class NotesBox{
  static const String _boxName = 'navigation';

  static Future<Box> openBox() async {
    return await Hive.openBox(_boxName);
  }

  static Future<void> addNotes(Map<String, dynamic> note) async {
    final Box box = await openBox();
    await box.add(note);
  }

  static Future<void> removeNotes(int index) async {
    final Box box = await openBox();
    await box.deleteAt(index);
  }

  static Future<void> editNotes(Map<String, dynamic> note, int index) async {
    final Box box = await openBox();
    await box.putAt(index, note);
  }

  static Future<List<Map<dynamic, dynamic>>> getNotes() async {
    final Box box = await openBox();
    final List<Map<dynamic, dynamic>> notes = [];
    for (int i = 0; i < box.length; i++) {
      notes.add(box.getAt(i));
    }
    return notes;
  }
}