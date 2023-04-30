import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/Answers.dart';
import 'package:wits_overflow/ProfileEdit.dart';
import 'package:wits_overflow/signin.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final user = FirebaseAuth.instance.currentUser!;

  void answer() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CounterScreenState(),
    ));
  }

  void toprofile() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProfileEdit(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue),
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Image(
                  image: AssetImage('images/WITS.png'),
                ),
              ),
            ),
            ListTile(
              //Icon tiles for each option
              leading: Icon(Icons.person),
              title: const Text("Profile"),
              subtitle: Text(
                user.email!,
                style: const TextStyle(color: Colors.grey),
              ),
              onTap: () {
                toprofile();
              },
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: const Text("Nofications"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginPage(
                    onTap: () {},
                  ),
                ));
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        //Alignments of different tiles
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      "Dashboard",
                      style: TextStyle(
                          color: Colors.black, //Colour of background
                          fontSize: 26.0,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  //const Icon(Icons.menu, color: Colors.black, size: 50.0),
                  Image.asset("images/conversation.png", width: 50.0)
                ],
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
                            color: Colors.blue,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: answer,
                                child: Column(
                                  children: [
                                    Image.asset("images/list.png", width: 64.0),
                                    const SizedBox(height: 10.0),
                                    const Text("Questions and answers",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20.0)),
                                    const SizedBox(height: 5.0),
                                    // Text( "2 questions", style :TextStyle(
                                    //     color: Colors.white,
                                    //     fontWeight: FontWeight.w100
                                    // ))
                                  ],
                                ),
                              ),
                            )))),
                    SizedBox(
                        //Size of boxes in relation to screen
                        width: 160.0,
                        height: 160.0,
                        child: Card(
                            color: Colors.blue,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset("images/medal.png", width: 64.0),
                                  const SizedBox(height: 10.0),
                                  const Text("View Achievements",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 20.0)),
                                  const SizedBox(height: 5.0),
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
                            color: Colors.blue,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset("images/interpretation.png",
                                      width: 64.0),
                                  const SizedBox(height: 10.0),
                                  const Text("View Past Activities",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 20.0)),
                                  const SizedBox(height: 5.0),
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
