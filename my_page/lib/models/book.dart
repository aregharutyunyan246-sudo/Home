
enum BookGenre {
  novel,
  history,
  fantasy,
  poetry,
}

extension BookGenreExtension on BookGenre {
  String get title {
    switch (this) {
      case BookGenre.novel:
        return 'Վեպ';
      case BookGenre.history:
        return 'Պատմություն';
      case BookGenre.fantasy:
        return 'Ֆանտաստիկա';
      case BookGenre.poetry:
        return 'Բանաստեղծություն';
    }
  }
}

class Book {
  final int id;
  final String title;
  final String author;
  final BookGenre genre;

  bool isRead;
  int rating;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    this.isRead = false,
    this.rating = 0,
  });
}
