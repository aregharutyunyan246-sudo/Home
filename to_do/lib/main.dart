import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyPageState();
}

class _MyPageState extends State<MyApp> {
  TextEditingController text = TextEditingController();

  List<String> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do'),
      ),
      body: Column(
        children: [
          TextField(
            controller: text,
            decoration: InputDecoration(
              hintText: 'Գրիր առաջադրանքը',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (text.text.isNotEmpty) {
                setState(() {
                  tasks.add(text.text);
                  text.clear();
                });
              }
            },
            child: Text('Ավելացնել'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        tasks.removeAt(index);
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