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

  @override
  void initState() {
    _titleController = widget.title == null
        ? TextEditingController()
        : TextEditingController(text: widget.title);
    _descriptionController = widget.description == null
        ? TextEditingController()
        : TextEditingController(text: widget.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.index == null
            ? Text(
                'Add Note',
                style:
                    TextStyle(fontSize: 40.sp, fontFamily: 'AlexBrush-Regular'),
              )
            : Text(
                'Edit Note',
                style:
                    TextStyle(fontSize: 40.sp, fontFamily: 'AlexBrush-Regular'),
              ),
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
                textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.grey[700]),
              ),
              const SizedBox(height: 10),
              myTextField(
                hintText: 'Description',
                controller: _descriptionController!,
                maxLines: 25,
                textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey[700]),
              ),
              const SizedBox(height: 10),
              widget.index == null
                  ? TextButton(
                      child: Text('Add', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.deepPurple),),
                      onPressed: () {
                        Provider.of<Notes>(context, listen: false).addNote(
                          title: _titleController!.text,
                          description: _descriptionController!.text,
                        );
                        Navigator.of(context).pop();
                      },
                    )
                  : TextButton(
                      child: const Text('Edit'),
                      onPressed: () {
                        Provider.of<Notes>(context, listen: false).editNote(
                          index: widget.index!,
                          title: _titleController!.text,
                          description: _descriptionController!.text,
                        );
                        Navigator.of(context).pop();
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget myTextField(
      {required String hintText,
      required TextEditingController controller,
      required int maxLines,
      required TextStyle? textStyle}) {
    return TextField(
      controller: controller,
      style: textStyle!.copyWith(color: Theme.of(context).textTheme.titleLarge!.color),
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
