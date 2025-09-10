import 'package:annoto/login_signup/login_page.dart';
import 'package:annoto/screen_manager.dart';
import 'package:annoto/ui_elements/main_appBar.dart';
import 'package:annoto/ui_elements/time_greeting.dart';
import 'package:annoto/ui_elements/transitions.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    return Scaffold(
      appBar: CustomAppbar(title: "HOME", firstBtnFunc: (){
        supabase.auth.signOut();
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You have been Signed Out!"), backgroundColor: Colors.red),
      );
        Navigator.of(context).pushReplacement(transitionPage(() => LoginPage()));
      },),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              getTimeBasedGreeting().toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
