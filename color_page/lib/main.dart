
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
  State<MyApp> createState() => _ColorScreenState();
}

class _ColorScreenState extends State<MyApp> {
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Գույնի փոփոխություն'),
        centerTitle: true,
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            setState(() {
              index++;

              if (index == colors.length) {
                index = 0;
              }
            });
          },
          child: Container(
            width: 150,
            height: 150,
            color: colors[index],
          ),
        ),
      ),
    );
  }
}
