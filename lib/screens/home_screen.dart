import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
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
  int _currentIndex = 0;
  @override
  void initState() {
    _currentIndex =
        Hive.box('navigation').get('_currentIndex', defaultValue: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notesData = Provider.of<Notes>(context);
    final notes = Provider.of<Notes>(context).items;

    Widget mainWidget = _currentIndex == 0
        ? buildSliverList(notesData, notes)
        : _currentIndex == 1
            ? buildSliverGrid(notesData, notes)
            : buildSliverGrid2(notesData, notes);

    void _onNavItemTapped(int index) {
      setState(() {
        if (index == 0) {
          mainWidget = buildSliverList(notesData, notes);
        } else if (index == 1) {
          mainWidget = buildSliverGrid(notesData, notes);
        } else if (index == 2) {
          mainWidget = buildSliverGrid2(notesData, notes);
        }
        _currentIndex = index;
      });
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'notes',
      //     style: TextStyle(fontSize: 40.sp, fontFamily: 'AlexBrush-Regular'),
      //   ),
      //   actions: [
      //     IconButton(onPressed: (){
      //       Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNoteScreen()));
      //     }, icon: Icon(Icons.add)),
      //     SizedBox(width: 10.w),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildSliverPage(notesData, notes, _onNavItemTapped, mainWidget),
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

  Widget buildSliverPage(notesData, notes, onPressed, mainSliverWidget) {
    return CustomScrollView(
      slivers: [
        mySliverAppBar(onPressed),
        mainSliverWidget,
      ],
    );
  }

  Widget buildSliverList(notesData, notes) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => noteTile(
          context,
          index: index,
          id: notes[index].id,
          title: notes[index].title,
          date: notes[index].date,
          description: notes[index].description,
          isFavorite: notes[index].isFavorite,
          isImportant: notes[index].isImportant,
          onFavoriteTap: () {
            notesData.toggleIsFavorite(index);
          },
          onDeleteTap: () {
            notesData.deleteNoteById(index);
          },
        ),
        childCount: notes.length,
      ),
    );
  }

  Widget buildSliverGrid(notesData, notes) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => noteTile(
          context,
          index: index,
          id: notes[index].id,
          title: notes[index].title,
          date: notes[index].date,
          description: notes[index].description,
          isFavorite: notes[index].isFavorite,
          isImportant: notes[index].isImportant,
          onFavoriteTap: () {
            notesData.toggleIsFavorite(index);
          },
          onDeleteTap: () {
            notesData.deleteNoteById(index);
          },
        ),
        childCount: notes.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 4,
      ),
    );
  }

  Widget buildSliverGrid2(notesData, notes) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => noteTile(
          context,
          index: index,
          id: notes[index].id,
          title: notes[index].title,
          date: notes[index].date,
          description: notes[index].description,
          isFavorite: notes[index].isFavorite,
          isImportant: notes[index].isImportant,
          onFavoriteTap: () {
            notesData.toggleIsFavorite(index);
          },
          onDeleteTap: () {
            notesData.deleteNoteById(index);
          },
        ),
        childCount: notes.length,
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        childAspectRatio: 3 / 4,
      ),
    );
  }

  Widget mySliverAppBar(onPressed) {
    return SliverAppBar(
      title: Text(
        'notes',
        style: TextStyle(fontSize: 40.sp, fontFamily: 'AlexBrush-Regular'),
      ),
      actions: [
        DropdownButton(
          underline: Container(),
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          items: [
            DropdownMenuItem(
              child: Text('list'),
              value: 'list',
            ),
            DropdownMenuItem(
              child: Text('grid 2'),
              value: 'grid 2',
            ),
            DropdownMenuItem(
              child: Text('grid 3'),
              value: 'grid 3',
            ),
          ],
          onChanged: (value) {
            if (value == 'list') {
              Hive.box('navigation').put('_currentIndex', 0);
              onPressed(0);
            } else if (value == 'grid 3') {
              Hive.box('navigation').put('_currentIndex', 1);
              onPressed(1);
            } else if (value == 'grid 2') {
              Hive.box('navigation').put('_currentIndex', 2);
              onPressed(2);
            }
          },
        ),
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddNoteScreen()));
            },
            icon: Icon(Icons.add)),
        SizedBox(width: 10.w),
      ],
    );
  }
}
