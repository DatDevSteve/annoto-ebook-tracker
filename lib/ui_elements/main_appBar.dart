import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      toolbarHeight: 70,
      title: Text(
        title,
        style: GoogleFonts.inriaSans(
          color: Color.fromRGBO(7, 113, 55, 1),
          fontWeight: FontWeight.w900,
          letterSpacing: 10,
          fontSize: 30,
        ),
      ),
      foregroundColor: Colors.white,
      backgroundColor: Color.fromRGBO(16, 19, 24, 1),
      centerTitle: true,
      leading: TextButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
        child: Icon(Icons.exit_to_app, color: Colors.white, size: 30),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Icon(Icons.account_circle, color: Colors.white, size: 35),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
