import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Function? firstBtnFunc;
  final Function? secondBtnFunc;
  final Icons? firstBtnIco;
  final Icons? secondBtnIco;

  const CustomAppbar({
    super.key,
    required this.title,
    this.firstBtnFunc,
    this.secondBtnFunc,
    this.firstBtnIco,
    this.secondBtnIco,
  });

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      toolbarHeight: 70,
      title: Text(
        widget.title,
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
        onPressed: widget.firstBtnFunc as void Function()?,
        child: Icon((widget.firstBtnIco ?? Icons.exit_to_app) as IconData?, color: Colors.white, size: 30),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.secondBtnFunc;
          },
          child: Icon((widget.secondBtnIco ?? Icons.account_circle) as IconData?, color: Colors.white, size: 35),
        ),
      ],
    );
  }

  Size get preferredSize => const Size.fromHeight(70);
}
