import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/home_page.dart';

void main() async {
  await Hive.initFlutter();
  // open the box
  await Hive.openBox('tasks');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          background: Colors.deepPurple[100],
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.ibmPlexSansThaiLoopedTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}
