import 'package:call_app/pages/home_page.dart';
import 'package:call_app/services/database/objectbox.dart';
import 'package:flutter/material.dart';

late ObjectBox objectbox;

void main() async {
  // This is required so ObjectBox can get the application directory to store the database in.
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
