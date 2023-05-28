import 'package:flutter/material.dart';

class CommentButton extends StatelessWidget {
  void Function()? onTap;
  final String username;

  CommentButton({super.key, required this.onTap, required this.username});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.comment,
        color: Colors.grey,
        size: 20,
      ),
    );
  }
}
