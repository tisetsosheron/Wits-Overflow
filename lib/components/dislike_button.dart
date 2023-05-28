import 'package:flutter/material.dart';

class DislikeButton extends StatelessWidget {
  final bool isDisliked;
  void Function()? onTap;

  DislikeButton({super.key, required this.isDisliked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.thumb_down,
        size: 20,
        color: isDisliked ? Colors.blue : Colors.grey,
      ),
    );
  }
}
