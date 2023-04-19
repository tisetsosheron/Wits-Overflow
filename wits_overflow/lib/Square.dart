import 'package:flutter/material.dart';

class MySquare extends StatelessWidget {
  //const MySquare({super.key});

  final String child;
  MySquare({required this.child});



  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical : 8),
        child: Container(
          height: 100,
          color: Colors.grey[200],
          child: Center(
            child: Text(
            child, style: TextStyle(fontSize:20 ),
          ),

        ),
      ),
    );
  }
}