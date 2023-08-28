import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:untitled1/helpers/notes_box.dart';
import 'package:untitled1/models/note.dart';

class Notes with ChangeNotifier {
  // final Box _myBox = Hive.box('Notes');
  int id = 0;
  List<Note> _items = [];

  List<Note> get items {
    NotesBox.getNotes().then((value) {
      _items = value.map((e) => Note.fromMap(e)).toList();
      notifyListeners();
    });
    return [..._items];
  }

  List<Note> getImportantNotes() {
    List<Note> importantNotes = [];
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].isImportant) {
        importantNotes.add(_items[i]);
      }
    }
    return importantNotes;
  }

  bool get hasImportantNotes {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].isImportant) {
        return true;
      }
    }
    return false;
  }

  List<int> selectedItems = [];
  bool selecting = false;

  List<Note> evenNotes({bool isImportant = false}) {
    List<Note> evenNotes = [];
    List<Note> notes = isImportant ? getImportantNotes() : _items;
    for (int i = 0; i < notes.length; i++) {
      if (i % 2 == 0) {
        evenNotes.add(notes[i]);
      }
    }
    return evenNotes;
  }

  List<Note> oddNotes({bool isImportant = false}) {
    List<Note> oddNotes = [];
    List<Note> notes = isImportant ? getImportantNotes() : _items;
    for (int i = 0; i < notes.length; i++) {
      if (i % 2 != 0) {
        oddNotes.add(notes[i]);
      }
    }
    return oddNotes;
  }

  void addNote({
    required String title,
    required String description,
    isImportant = false,
    colorIndex = 0,
  }) {
    // final id = DateTime.now().toString();
    Note noteNew = Note(
      id: id.toString(),
      title: title,
      description: description,
      date: DateTime.now(),
      isImportant: isImportant,
      colorIndex: colorIndex,
    );
    // _myBox.add(noteNew);
    _items.add(noteNew);
    NotesBox.addNotes(noteNew.toMap());
    id++;
    notifyListeners();
  }

  void editNote({
    required String title,
    required String description,
    required int index,
    isImportant = false,
    colorIndex = 0,
  }) {
    _items[index].title = title;
    _items[index].description = description;
    _items[index].date = DateTime.now();
    _items[index].isImportant = isImportant;
    _items[index].colorIndex = colorIndex;
    NotesBox.editNotes(_items[index].toMap(), index);
    notifyListeners();
  }

  void fetchNotes() {
    _items.clear();

    NotesBox.getNotes().then((value) {
      _items = value.map((e) => Note.fromMap(e)).toList();
      notifyListeners();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void deleteNoteAt(int index) {
    _items.removeAt(index);
    NotesBox.removeNotes(index);
    notifyListeners();
  }

  void addSelected(int index) {
    if (selectedItems.contains(index)) {
      return;
    }
    selectedItems.add(index);
    print(selectedItems.length);
    notifyListeners();
  }

  void removeSelected(int index) {
    selectedItems.remove(index);
    notifyListeners();
  }

  bool isSelected(int index) {
    return selectedItems.contains(index);
  }

  void deleteSelected() {
    selectedItems.sort();
    for (int i = selectedItems.length - 1; i >= 0; i--) {
      _items.removeAt(selectedItems[i]);
      NotesBox.removeNotes(selectedItems[i]);
    }
    selectedItems.clear();
    selecting = false;
    notifyListeners();
  }

  void addSelectedToImportant() {
    selectedItems.sort();
    for (int i = selectedItems.length - 1; i >= 0; i--) {
      _items[selectedItems[i]].isImportant = true;
      NotesBox.editNotes(_items[selectedItems[i]].toMap(), selectedItems[i]);
    }
    selectedItems.clear();
    selecting = false;
    notifyListeners();
  }

  void removeSelectedFromImportant() {
    selectedItems.sort();
    for (int i = selectedItems.length - 1; i >= 0; i--) {
      _items[selectedItems[i]].isImportant = false;
      NotesBox.editNotes(_items[selectedItems[i]].toMap(), selectedItems[i]);
    }
    selectedItems.clear();
    selecting = false;
    notifyListeners();
  }

  void changeNoteColor(int index, int colorIndex) {
    _items[index].colorIndex = colorIndex;
    NotesBox.editNotes(_items[index].toMap(), index);
    notifyListeners();
  }
}
