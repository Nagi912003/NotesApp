import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/models/note.dart';
import 'package:untitled1/screens/add_note_screen.dart';
import 'package:untitled1/widgets/note_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final notesData = Provider.of<Notes>(context, listen: false);
    final notes = Provider.of<Notes>(context, listen: false).items;

    // void _onNavItemTapped(int index) {
    //   setState(() {
    //
    //   });
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'notes',
          style: TextStyle(fontSize: 40.sp, fontFamily: 'AlexBrush-Regular'),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddNoteScreen()));
              },
              icon: Icon(Icons.add)),
          SizedBox(width: 10.w),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildPage(notesData, notes),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNoteScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildPage(Notes notesData, List<Note> notes) {
    return SingleChildScrollView(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: NotesColumn(notesData, notes, notesData.evenNotes()),
          ),
          Expanded(
            child: NotesColumn(notesData, notes, notesData.oddNotes()),
          ),
        ],
      ),
    );
  }

  Widget NotesColumn(Notes notesData, List<Note> notes, List<Note> notesList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: notesList
          .map(
            (e) => NoteTile(
              index: notes.indexOf(e),
            ),
          )
          .toList(),
    );
  }
}

//   Wrap(
//   children: notes.map((e) => noteTile(
//     context,
//     index: notes.indexOf(e),
//     id: e.id,
//     title: e.title,
//     date: e.date,
//     description: e.description,
//     isFavorite: e.isFavorite,
//     isImportant: e.isImportant,
//     onFavoriteTap: () {
//       notesData.toggleIsFavorite(notes.indexOf(e));
//     },
//     onDeleteTap: () {
//       notesData.deleteNoteById(notes.indexOf(e));
//     },
//   )).toList(),
// )
