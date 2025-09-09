import 'package:flutter/foundation.dart';
import 'package:annoto/screen_manager.dart';
import 'package:annoto/login_signup/login_page.dart';
import 'package:annoto/welcome.dart';
import 'package:flutter/material.dart';
import 'package:annoto/ui_elements/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      title: "Annoto eBook Library",
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
