
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Իմ պրոֆիլը'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.person,
                size: 65,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Արեգ Հարությունյան',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Flutter սովորող',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 35),
            Row(
              children: [
                Icon(Icons.email, color: Colors.blue),
                SizedBox(width: 15),
                Text('areg@gmail.com'),
              ],
            ),
            SizedBox(height: 35),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.green),
                SizedBox(width: 15),
                Text('+374 99 123456'),
              ],
            ),
            SizedBox(height: 35),
            Row(
              children: [
                Icon(Icons.location_city, color: Colors.red),
                SizedBox(width: 15),
                Text('Երևան'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
