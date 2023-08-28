import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:untitled1/helpers/notes_box.dart';
import 'package:untitled1/models/note.dart';

class Notes with ChangeNotifier{

  // final Box _myBox = Hive.box('Notes');
  List <Note> _items = [];

  List <Note> get items {
    NotesBox.getNotes().then((value) {
      _items = value.map((e) => Note.fromMap(e)).toList();
      notifyListeners();
    });
    return [..._items];
  }

  List<int> selectedItems = [];
  bool selecting = false;

  List<Note> evenNotes(){
    List<Note> evenNotes = [];
    for(int i=0; i<_items.length; i++){
      if(i%2==0){
        evenNotes.add(_items[i]);
      }
    }
    return evenNotes;
  }

  List<Note> oddNotes(){
    List<Note> oddNotes = [];
    for(int i=0; i<_items.length; i++){
      if(i%2!=0){
        oddNotes.add(_items[i]);
      }
    }
    return oddNotes;
  }


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
    // _myBox.add(noteNew);
    _items.add(noteNew);
    NotesBox.addNotes(noteNew.toMap());
    notifyListeners();
  }

  void editNote({
    required String title,
    required String description,
    required int index,
  }){
    _items[index].title = title;
    _items[index].description = description;
    _items[index].date = DateTime.now();
    NotesBox.editNotes(_items[index].toMap(), index);
    notifyListeners();
  }

  void fetchNotes(){
    _items.clear();

    NotesBox.getNotes().then((value) {
      _items = value.map((e) => Note.fromMap(e)).toList();
      notifyListeners();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void deleteNoteAt(int index){
    _items.removeAt(index);
    NotesBox.removeNotes(index);
    notifyListeners();
  }

  void addSelected(int index){
    if(selectedItems.contains(index)){
      return;
    }
    selectedItems.add(index);
    print(selectedItems.length);
    notifyListeners();
  }

  void removeSelected(int index){
    selectedItems.remove(index);
    notifyListeners();
  }

  bool isSelected(int index){
    return selectedItems.contains(index);
  }

}