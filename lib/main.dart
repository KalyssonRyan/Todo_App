import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/pages/home.dart';
import 'package:todo/pages/saiba_mais.dart';

void main() async{
  await Hive.initFlutter();

  // ignore: unused_local_variable
  var box = await Hive.openBox('mybox');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.green),
      routes: {
        '/saiba_mais': (context) => SaibaMais()
      },
    );
  }
}
