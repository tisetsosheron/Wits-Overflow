//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/homepage.dart';

import 'Square.dart';
//import 'package:flutter/services.dart';

class ViewQuestions extends StatefulWidget {
  const ViewQuestions({super.key});


  @override
  State<ViewQuestions> createState() => _ViewQuestionsState();
}


class _ViewQuestionsState extends State<ViewQuestions>{
  bool isSearching= false;
  final List _Questions= [
    'Question 1',
    'Question 2',
    'Question 3',
    'Question 4',
    'Question 5',
    'Question 5',

  ];


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.white70,
       title:!isSearching? Text(
         "Wits Overflow",
       style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold
       ))
       :TextField(
         decoration: InputDecoration(
           icon: Icon(Icons.search),
           hintText: "search question by keyword",
         ),

         ) ,
       actions: [
         isSearching?
         IconButton(

           icon: Icon(Icons.cancel),
           color: Colors.black,
           onPressed:(){
             setState(() {
               this.isSearching = false;

             });
           },
         )
         :IconButton(

             icon: Icon(Icons.search),
             color: Colors.black,
             onPressed:(){
               setState(() {
                this.isSearching = true;

               });
             },
         ),


         IconButton(
             icon: Icon(Icons.home),
             color: Colors.blue,
             onPressed: () {
               Navigator.push(
               context,
               MaterialPageRoute(builder: (context)=>  Dashboard()),
               );}),
         IconButton(
             onPressed:(){},
             icon: Icon(Icons.person),
             color: Colors.deepOrange),

         IconButton(
             onPressed:(){},
             icon: Icon(Icons.question_mark_outlined),
             color: Colors.black)


       ],
   
   ),


     body:
     ListView.builder(
       itemCount: _Questions.length,
       itemBuilder: (context, index){
         return MySquare(
           child: _Questions[index],);
       },
     ),


  );

  }
}