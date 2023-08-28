import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:untitled1/models/note.dart';
import '../providers/notes.dart';
import 'package:untitled1/screens/add_note_screen.dart';
import 'package:untitled1/widgets/note_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future googleFontsPending;
  @override
  void initState() {
    super.initState();

    googleFontsPending = GoogleFonts.pendingFonts([
      GoogleFonts.montserrat(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final notesData = Provider.of<Notes>(context);
    final notes = Provider.of<Notes>(context, listen: false).items;

    return Scaffold(
      appBar: MyAppBar(notesData.selecting),
      body: FutureBuilder(
          future: googleFontsPending,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: const CircularProgressIndicator());
            }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildPage(notesData, notesData.getImportantNotes(),
                      isImportant: true),
                  if (notesData.hasImportantNotes) Divider(),
                  buildPage(notesData, notes),
                ],
              ),
            ),
            // Container(
            //   width: 1.sw,
            //   height: 1.sh,
            //   color: Color(0xff1f191f),
            // ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(_createRoute(null, null, null));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildPage(Notes notesData, List<Note> notes,
      {bool isImportant = false}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: NotesColumn(
              notesData, notes, notesData.evenNotes(isImportant: isImportant)),
        ),
        Expanded(
          child: NotesColumn(
              notesData, notes, notesData.oddNotes(isImportant: isImportant)),
        ),
      ],
    );
  }

  Widget NotesColumn(Notes notesData, List<Note> notes, List<Note> notesList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: notesList
          .map(
            (e) => NoteTile(
              index: int.parse(e.id),
            ),
          )
          .toList(),
    );
  }

  AppBar MyAppBar(bool selecting) {
    return AppBar(
      title: Text(
        'notes',
        style: TextStyle(fontSize: 40.sp, fontFamily: 'AlexBrush-Regular'),
      ),
      actions: selecting
          ? [
              IconButton(
                  onPressed: () {
                    Provider.of<Notes>(context, listen: false).selecting =
                        false;
                    Provider.of<Notes>(context, listen: false)
                        .selectedItems
                        .clear();
                  },
                  icon: Icon(Icons.close)),
              IconButton(
                  onPressed: () {
                    Provider.of<Notes>(context, listen: false)
                        .addSelectedToImportant();
                  },
                  icon: Icon(Icons.star_outlined)),
              IconButton(
                  onPressed: () {
                    Provider.of<Notes>(context, listen: false)
                        .removeSelectedFromImportant();
                  },
                  icon: Icon(Icons.star_border_outlined)),
              IconButton(
                  onPressed: () {
                    Provider.of<Notes>(context, listen: false).deleteSelected();
                  },
                  icon: Icon(Icons.delete_outline)),
            ]
          : [
              IconButton(
                  onPressed: () {
                    Provider.of<Notes>(context, listen: false).selecting = true;
                  },
                  icon: Icon(Icons.select_all)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNoteScreen()));
                  },
                  icon: Icon(Icons.add)),
            ],
    );
  }
}

Route _createRoute(int? index, String? title, String? description) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => index != null
        ? AddNoteScreen(index: index, title: title, description: description)
        : AddNoteScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
