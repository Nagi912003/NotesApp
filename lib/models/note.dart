class Note {
  String id;
  String title;
  String description;
  DateTime date;
  bool isImportant;
  bool isFavorite;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isImportant = false,
    this.isFavorite = false,
  });

  Map<String,dynamic> noteMap(){
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'isImportant': isImportant,
      'isFavorite': isFavorite,
    };
  }


}