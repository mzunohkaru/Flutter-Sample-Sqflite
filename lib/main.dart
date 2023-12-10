import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_sample/page/notes_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes SQLite',
        theme: ThemeData(primaryColor: Colors.white, useMaterial3: true),
        home: NotesPage(),
      );
}
