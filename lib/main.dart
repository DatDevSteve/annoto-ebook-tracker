import 'package:flutter/foundation.dart';
import 'package:annoto/screen_manager.dart';
import 'package:annoto/login_signup/login_page.dart';
import 'package:annoto/welcome.dart';
import 'package:flutter/material.dart';
import 'package:annoto/ui_elements/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/.env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
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
    final session = Supabase.instance.client.auth.currentSession;
    final Widget homeScreen = session != null ? HomeScreen() : WelcomePage();
    return MaterialApp(
      theme: themeData,
      title: "Annoto: Reading Companion ",
      debugShowCheckedModeBanner: false,
      home: homeScreen,
    );
  }
}
