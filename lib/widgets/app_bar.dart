import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: Color(0xFF006A71),
      elevation: 4,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
