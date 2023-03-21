import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu, color: Colors.black, size: 50.0),
                  Image.asset("assets/conversation.png", width: 50.0)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "Welcome to your Dashboard",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: [
                    SizedBox(
                        width: 160.0,
                        height: 160.0,
                        child: Card(
                            color: Color.fromARGB(155, 21, 21, 21),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset("assets/list.png", width: 64.0),
                                  SizedBox(height: 10.0),
                                  Text("Questions and answers",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0)),
                                  SizedBox(height: 5.0),
                                  // Text( "2 questions", style :TextStyle(
                                  //     color: Colors.white,
                                  //     fontWeight: FontWeight.w100
                                  // ))
                                ],
                              ),
                            )))),
                    SizedBox(
                        width: 160.0,
                        height: 160.0,
                        child: Card(
                            color: Color.fromARGB(155, 21, 21, 21),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset("assets/medal.png", width: 64.0),
                                  SizedBox(height: 10.0),
                                  Text("View Achievements",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0)),
                                  SizedBox(height: 5.0),
                                  // Text( "2 questions", style :TextStyle(
                                  //    color: Colors.white,
                                  //    fontWeight: FontWeight.w100
                                  // ))
                                ],
                              ),
                            )))),
                    SizedBox(
                        width: 160.0,
                        height: 160.0,
                        child: Card(
                            color: Color.fromARGB(155, 21, 21, 21),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset("assets/interpretation.png",
                                      width: 64.0),
                                  SizedBox(height: 10.0),
                                  Text("View Past Activities",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0)),
                                  SizedBox(height: 5.0),
                                  // Text( "2 questions", style :TextStyle(
                                  //     color: Colors.white,
                                  //     fontWeight: FontWeight.w100
                                  // ))
                                ],
                              ),
                            ))))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
