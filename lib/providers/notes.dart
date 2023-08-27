import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled1/models/note.dart';

class Notes with ChangeNotifier{

  final Box _myBox = Hive.box<Note>('Notes');
  List <Note> items = [];


  void addNote({
    required String title,
    required String description,
  }){
    final id = DateTime.now().toString();
    Note noteNew= Note(
      id: id,
      title: title,
      description: description,
      date: DateTime.now(),
    );
    _myBox.add(noteNew);
    items.add(noteNew);
    notifyListeners();
  }

  void editNote({
    required String title,
    required String description,
    required int index,
  }){
    items[index].title = title;
    items[index].description = description;
    _myBox.putAt(index, items[index]);
    notifyListeners();
  }

  void fetchNotes(){
    items.clear();

    for(int i=0; i<_myBox.length; i++){
      items.add(_myBox.getAt(i)!);

    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void deleteNoteById(int index){
    items.removeAt(index);
    _myBox.deleteAt(index);
    notifyListeners();
  }

  void toggleIsFavorite(int index){
    items[index].isFavorite = !items[index].isFavorite;
    _myBox.putAt(index, items[index]);
    notifyListeners();
  }

}