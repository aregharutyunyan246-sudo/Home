
import 'package:flutter/material.dart';
import '../models/book.dart';

class BookTile extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;
  final ValueChanged<bool?> onChanged;

  const BookTile({
    super.key,
    required this.book,
    required this.onTap,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: book.isRead,
        onChanged: onChanged,
      ),
      title: Text(
        book.title,
        style: TextStyle(
          decoration: book.isRead
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(book.author),
      trailing: book.rating > 0
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text('${book.rating}'),
              ],
            )
          : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
