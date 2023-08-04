import 'package:flutter/cupertino.dart';
import 'package:untitled1/models/note.dart';

class Notes with ChangeNotifier{
  final List<Note> _items = [];

  List get items{
    return [..._items];
  }


  void addNote({
    required String title,
    required String description,
  }){
    _items.add(
        Note(id: DateTime.now().toString(),
            title: title, description: description, date: DateTime.now())
      );
    notifyListeners();
  }

  void deleteNoteById(String id){
    _items.removeWhere((element) => element.id == id);
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

}