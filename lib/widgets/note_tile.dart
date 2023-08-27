import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/add_note_screen.dart';


Widget noteTile(context,
    {
      required int index,
      id,
      title,
      date,
      description,
      isFavorite,
      isImportant,
      onFavoriteTap,
      onDeleteTap}) {
  return Stack(
    children: [
      InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNoteScreen(index: index,title: title, description: description,)));
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25.h,
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                  child: Text(
                    date.toString().substring(0, 10),
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                  width: 1.sw,
                ),
                SizedBox(
                  height: 50.h,
                  child: Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        top: 5.h,
        right: 10.h,
        child: DropdownButton(
          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).colorScheme.error,
          ),
          borderRadius: BorderRadius.circular(10),
          menuMaxHeight: 60.h,
          underline: Container(),
          items: [
            DropdownMenuItem(
              value: 'delete',
              child: Text(
                'Delete',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
          onChanged: (value) {
            if (value == 'delete') {
              onDeleteTap();
              // Navigator.of(context).pushNamed(AddNoteScreen.routeName);
            }
          },
        ),
      ),
      Positioned(
        bottom: 5.h,
        right: 5.h,
        child: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color:
            isFavorite ? Theme.of(context).colorScheme.error : Colors.grey,
          ),
          onPressed: onFavoriteTap,
        ),
      ),
    ],
  );
}
