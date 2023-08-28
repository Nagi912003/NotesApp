import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/notes.dart';
import '../screens/add_note_screen.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String description;

  CustomCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 1.sw,
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != '')
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                Text(
                  description,
                  maxLines: title != '' ? 12 : 13,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NoteTile extends StatefulWidget {
  final index;
  const NoteTile({super.key, this.index});
  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  @override
  Widget build(BuildContext context) {
    final notesData = Provider.of<Notes>(context);
    final notes = Provider.of<Notes>(context, listen: false).items;
    // print(notesData.isSelected(widget.index));
    return Stack(
      children: [
        InkWell(
          onTap: () {
            if (notesData.selecting == false) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddNoteScreen(
                        index: widget.index,
                        title: notes.elementAt(widget.index).title,
                        description: notes.elementAt(widget.index).description,
                      )));
            } else {
              if (notesData.isSelected(widget.index)) {
                print('removing');
                notesData.removeSelected(widget.index);
                if(notesData.selectedItems.length == 0){
                  notesData.selecting = false;
                }
              }else{
                print('adding');
                notesData.addSelected(widget.index);
              }
            }
          },
          onLongPress: () {
            if (notesData.selecting == false) {
              notesData.selecting = true;
            }
            notesData.addSelected(widget.index );
          },
          child: Container(
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: notesData.isSelected(widget.index)
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.surface,
            ),
            child: CustomCard(
              title: notes.elementAt(widget.index).title,
              description: notes.elementAt(widget.index).description,
            ),
          ),
        ),
      ],
    );
  }
}
