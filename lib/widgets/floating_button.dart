import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomFloatingButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Color(0xFF006A71),
      child: Icon(Icons.add, color: Colors.white),
    );
  }
}
