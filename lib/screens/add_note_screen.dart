import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/notes.dart';

class AddNoteScreen extends StatefulWidget {
  final int? index;
  final String? title;
  final String? description;
  const AddNoteScreen({super.key, this.title, this.description, this.index});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController? _titleController;
  TextEditingController? _descriptionController;
  bool isImportant = false;

  @override
  void initState() {
    _titleController = widget.title == null
        ? TextEditingController()
        : TextEditingController(text: widget.title);
    _descriptionController = widget.description == null
        ? TextEditingController()
        : TextEditingController(text: widget.description);

    if(widget.index != null){
      isImportant = Provider.of<Notes>(context, listen: false).items[widget.index!].isImportant;
    }
    super.initState();
  }

  void toggleImportant() {
    setState(() {
      isImportant = !isImportant;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        // backgroundColor: colorIndex == 0? Theme.of(context).colorScheme.background: colorIndex == 1? Colors.red: colorIndex == 2? Colors.blue: colorIndex == 3? Colors.green: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: widget.index == null
              ? Text(
                  'Add Note',
                  style: TextStyle(
                      fontSize: 40.sp, fontFamily: 'AlexBrush-Regular'),
                )
              : Text(
                  'Edit Note',
                  style: TextStyle(
                      fontSize: 40.sp, fontFamily: 'AlexBrush-Regular'),
                ),
          actions: [
            IconButton(
              onPressed: () {
                // change the color of the note
              },
              icon: Icon(Icons.color_lens_outlined),
            ),
            IconButton(
              onPressed: toggleImportant,
              icon: isImportant?Icon(Icons.star_rounded):Icon(Icons.star_border_rounded),
            ),
            SizedBox(width: 10.w)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 10),
                myTextField(
                  hintText: 'Title',
                  controller: _titleController!,
                  maxLines: 1,
                  textStyle: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.grey[700]),
                ),
                const SizedBox(height: 10),
                myTextField(
                  hintText: 'Description',
                  controller: _descriptionController!,
                  maxLines: 25,
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    if (_titleController!.text.isEmpty &&
        _descriptionController!.text.isEmpty &&
        widget.index == null) {
      return true;
    }
    if (_titleController!.text.isEmpty &&
        _descriptionController!.text.isEmpty &&
        widget.index != null) {
      Provider.of<Notes>(context, listen: false).deleteNoteAt(
        widget.index!,
      );
      return true;
    }

    widget.index == null
        ? Provider.of<Notes>(context, listen: false).addNote(
            title: _titleController!.text.trim(),
            description: _descriptionController!.text.trim(),
            isImportant: isImportant,
          )
        : Provider.of<Notes>(context, listen: false).editNote(
            index: widget.index!,
            title: _titleController!.text.trim(),
            description: _descriptionController!.text.trim(),
            isImportant: isImportant,
          );
    return true;
  }

  Widget myTextField(
      {required String hintText,
      required TextEditingController controller,
      required int maxLines,
      required TextStyle? textStyle}) {
    return TextField(
      controller: controller,
      style: textStyle!
          .copyWith(color: Theme.of(context).textTheme.titleLarge!.color),
      decoration: InputDecoration(
        hintStyle: textStyle,
        hintText:
            hintText, // This will be the label that disappears when typing
        border: InputBorder.none, // Remove the border
        focusedBorder: InputBorder.none, // Remove the border when focused
        enabledBorder: InputBorder.none, // Remove the border when not focused
        errorBorder:
            InputBorder.none, // Remove the border when there's an error
        disabledBorder: InputBorder.none, // Remove the border when disabled
        contentPadding: EdgeInsets.zero, // Remove any padding around the text
      ),
      maxLines: maxLines,
      onEditingComplete: () {
        FocusScope.of(context).nextFocus();
      },
    );
  }
}