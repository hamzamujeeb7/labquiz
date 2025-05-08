import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(MyApp());
}

class Book {
  String title;
  String author;

  Book({required this.title, required this.author});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Favourite Books',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Book> books = [];

  void addBook(Book book) {
    setState(() {
      books.add(book);
    });
  }

  void updateBook(int index, Book updatedBook) {
    setState(() {
      books[index] = updatedBook;
    });
  }

  void deleteBook(int index) {
    setState(() {
      books.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    timeDilation=10;
    return Scaffold(
      appBar: AppBar(title: Text('My Favourite Books')),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            title: Hero(
              tag: 'bookTitle$index',
              child: Material(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      book.author,
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: ()  {
              

             Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BookDetailScreen(
                        book: book,
                        index: index,
                        deleteBook: deleteBook,
                        updateBook: updateBook,
                      ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newBook = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBookScreen()),
          );
          if (newBook != null) addBook(newBook);
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddBookScreen extends StatelessWidget {
  final title = TextEditingController();
  final author = TextEditingController();

  AddBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Book")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: author,
              decoration: InputDecoration(labelText: "Author"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newBook = Book(title: title.text, author: author.text);
                Navigator.pop(context, newBook);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}

class BookDetailScreen extends StatelessWidget {
  final Book book;
  final int index;
  final Function deleteBook;
  final Function updateBook;

  const BookDetailScreen({
    super.key,
    required this.book,
    required this.index,
    required this.deleteBook,
    required this.updateBook,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'bookTitle$index',
              child: Material(
                child: Text(
                  'Book Title: ${book.title}',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Author: ${book.author}",
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final updatedBook = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditBookScreen(book: book),
                      ),
                    );
                    if (updatedBook != null) {
                      updateBook(index, updatedBook);
                    }
                  },
                  child: Text("Edit"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    deleteBook(index);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EditBookScreen extends StatelessWidget {
  final Book book;

  EditBookScreen({super.key, required this.book});

  final title = TextEditingController();
  final author = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Book")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: author,
              decoration: InputDecoration(labelText: "Author"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedBook = Book(
                  title: title.text,
                  author: author.text,
                );
                Navigator.pop(context, updatedBook);
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}




