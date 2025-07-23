import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class authAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const authAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      toolbarHeight: 70,
      title: Text(
        "ANNOTO",
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
