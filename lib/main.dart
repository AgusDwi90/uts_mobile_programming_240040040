import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(AppTanaman());
}

class AppTanaman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Tanaman',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomeScreen(),
    );
  }
}
