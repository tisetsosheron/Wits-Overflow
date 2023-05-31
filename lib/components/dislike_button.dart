import 'package:flutter/material.dart';

class DislikeButton extends StatelessWidget {
  final bool isDisliked;   // Represents whether the button is in a disliked state or not
  void Function()? onTap;  // Callback function to be executed when the button is tapped

  DislikeButton({super.key, required this.isDisliked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,   // Assigns the onTap callback function to the GestureDetector's onTap event
      child: Icon(
        Icons.thumb_down,
        size: 20,
        color: isDisliked ? Colors.blue : Colors.grey,  // Sets the color based on the isDisliked flag
      ),
    );
  }
}

