import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled1/models/note.dart';

class Notes with ChangeNotifier{

  final Box _myBox = Hive.box('notes');

  List<Note> _items = [];
  List itemsIds = [];

  List get items{
    return [..._items];
  }


  void addNote({
    required String title,
    required String description,
  }){
    final id = DateTime.now().toString();
    _items.add(
        Note(id: id,
            title: title, description: description, date: DateTime.now())
      );
    if(!_myBox.containsKey(id)){
      _myBox.put(id, Note(id: DateTime.now().toString(),
        title: title, description: description, date: DateTime.now()).noteMap());
      itemsIds.add(id);
      _myBox.put('itemsIds', itemsIds);
    }



    notifyListeners();
  }

  void fetchNotes(){
    if(!_myBox.containsKey('itemsIds')){
      _myBox.put('itemsIds', []);
      return;
    }

    itemsIds.clear();
    _items.clear();
    itemsIds = _myBox.get('itemsIds');
    if (kDebugMode) {
      print(itemsIds);
    }

    itemsIds.forEach((NoteId) {
      final noteMap = _myBox.get(NoteId);
      Note note = noteFromMap(noteMap);
      if(!_items.contains(note)){
        _items.add(note);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void deleteNoteById(String id){
    _items.removeWhere((element) => element.id == id);
    _myBox.delete(id);
    notifyListeners();
  }

  void toggleIsFavorite(String id){
    _items.forEach((element) {
      if(element.id == id){
        element.isFavorite = !element.isFavorite;
      }
    });
    notifyListeners();
  }


  Note noteFromMap(Map map){
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      isImportant: map['isImportant'],
      isFavorite: map['isFavorite'],
    );
  }

  Map<String,dynamic> MapFromNote(Note note){
    return {
      'id': note.id,
      'title': note.title,
      'description': note.description,
      'date': note.date,
      'isImportant': note.isImportant,
      'isFavorite': note.isFavorite,
    };
  }
}