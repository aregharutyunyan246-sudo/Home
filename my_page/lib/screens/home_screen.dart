
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/book_tile.dart';
import 'book_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController searchController =
      TextEditingController();

  BookGenre? selectedGenre;

  final List<Book> books = [
    Book(id: 1, title: 'Անուշ', author: 'Հովհաննես Թումանյան', genre: BookGenre.poetry),
    Book(id: 2, title: 'Սամվել', author: 'Րաֆֆի', genre: BookGenre.history),
    Book(id: 3, title: 'Գիքոր', author: 'Հովհաննես Թումանյան', genre: BookGenre.novel),
    Book(id: 4, title: 'Փոքրիկ իշխանը', author: 'Անտուան դը Սենտ-Էքզյուպերի', genre: BookGenre.fantasy),
    Book(id: 5, title: 'Դավիթ Բեկ', author: 'Րաֆֆի', genre: BookGenre.history),
    Book(id: 6, title: 'Մեծարենցի բանաստեղծությունները', author: 'Միսաք Մեծարենց', genre: BookGenre.poetry),
    Book(id: 7, title: 'Խենթը', author: 'Րաֆֆի', genre: BookGenre.novel),
    Book(id: 8, title: 'Հարի Փոթեր', author: 'Ջոան Ռոուլինգ', genre: BookGenre.fantasy),
    Book(id: 9, title: 'Գիքորի պատմությունը', author: 'Հովհաննես Թումանյան', genre: BookGenre.history),
    Book(id: 10, title: 'Սև գիրքը', author: 'Օրհան Փամուք', genre: BookGenre.novel),
  ];

  List<Book> get filteredBooks {
    final query = searchController.text.toLowerCase().trim();

    return books.where((book) {
      final matchesSearch =
          book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query);

      final matchesGenre =
          selectedGenre == null ||
          book.genre == selectedGenre;

      return matchesSearch && matchesGenre;
    }).toList();
  }

  void deleteBook(Book book) {
    final index = books.indexOf(book);

    setState(() {
      books.remove(book);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${book.title} ջնջվեց'),
        action: SnackBarAction(
          label: 'Վերականգնել',
          onPressed: () {
            setState(() {
              books.insert(index, book);
            });
          },
        ),
      ),
    );
  }

  Future<void> openDetails(Book book) async {
    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BookDetailsScreen(book: book),
      ),
    );

    if (result != null) {
      setState(() {
        book.rating = result;
        if (result > 0) {
          book.isRead = true;
        }
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayedBooks = filteredBooks;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Գրքերի ցուցակ (${books.where((b) => b.isRead).length} կարդացված)',
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Որոնել գիրք կամ հեղինակ...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    searchController.clear();
                    setState(() {});
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: const Text('Բոլորը'),
                    selected: selectedGenre == null,
                    onSelected: (_) {
                      setState(() {
                        selectedGenre = null;
                      });
                    },
                  ),
                ),

                ...BookGenre.values.map((genre) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(genre.title),
                      selected: selectedGenre == genre,
                      onSelected: (_) {
                        setState(() {
                          selectedGenre =
                              selectedGenre == genre ? null : genre;
                        });
                      },
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: displayedBooks.isEmpty
                ? const Center(
                    child: Text(
                      'Գիրք չի գտնվել',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.separated(
                    itemCount: displayedBooks.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final book = displayedBooks[index];

                      return Dismissible(
                        key: ValueKey(book.id),
                        direction: DismissDirection.horizontal,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (_) {
                          deleteBook(book);
                        },
                        child: BookTile(
                          book: book,
                          onTap: () => openDetails(book),
                          onChanged: (value) {
                            setState(() {
                              book.isRead = value ?? false;
                            });
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
