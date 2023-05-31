import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;   // Represents whether the button is in a liked state or not
  void Function()? onTap;  // Callback function to be executed when the button is tapped

  LikeButton({super.key, required this.isLiked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,   // Assigns the onTap callback function to the GestureDetector's onTap event
      child: Icon(
        Icons.thumb_up,
        color: isLiked ? Colors.blue : Colors.grey,  // Sets the color based on the isLiked flag
        size: 20,
      ),
    );
  }
}

