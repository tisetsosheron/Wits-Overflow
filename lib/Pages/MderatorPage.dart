import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/Pages/MainQuestions.dart';
import 'package:wits_overflow/Pages/ProfileEdit.dart';
import 'package:wits_overflow/Pages/signin.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:card_actions/card_action_button.dart';
import 'package:card_actions/card_actions.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ModeratorHome extends StatefulWidget {
  @override
  State<ModeratorHome> createState() => _ModeratorHomeState();
}

class _ModeratorHomeState extends State<ModeratorHome> {
  final user = FirebaseAuth.instance.currentUser!;

  bool _switch = false;
  int count = 0;
  ThemeData _dark = ThemeData(brightness: Brightness.dark);
  ThemeData _light = ThemeData(brightness: Brightness.light);

  void answer(String username) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CounterScreenState(currentUser: username),
    ));
  }

  Future getUserName() async {
    final user = FirebaseAuth.instance.currentUser;

    String username = " ";

    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((ds) {
        username = ds['username'];
      }).catchError((e) {
        print(e);
      });
    }

    print(username);

    answer(username);
  }

  Future<int> countDocuments() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('mainquestions');

    QuerySnapshot snapshot = await collectionRef.get();
    count = snapshot.size;

    return count;
  }

  void toprofile() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProfileEdit(),
    ));
  }

  @override
  void initState() {
    super.initState();
    countDocuments();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _switch ? _dark : _light,
      home: Scaffold(
        //tht app bar, must specify how each of the colours of the app bar will look
        appBar: _switch
            //purple in dark mode
            ? AppBar(backgroundColor: Colors.purple[200])
            //blue in light mode
            : AppBar(
                backgroundColor: Colors.blue[200],
              ),
        drawer: Drawer(
          //displayed as a list view
          child: ListView(
            children: [
              const DrawerHeader(
                child: Center(
                  child: Image(
                    image: AssetImage('images/WITS.png'),
                  ),
                ),
              ),

              //To be able to switch from light mode to dark mode and vice versa
              //switch button and the tex
              ListTile(
                leading: Switch(
                    value: _switch,
                    onChanged: (
                      _newvalue,
                    ) {
                      setState(() {
                        _switch = _newvalue;
                      });
                    }),
                title:
                    //There must be a text indicating whether we are in light mode or dark mode
                    _switch
                        ? Text("Dark Mode",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.purple[300],

                              //light mode text
                            ))
                        : Text("Light Mode",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.blue,
                            )),
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
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            //must toggle between light mode and dark
            Row(children: <Widget>[
              SizedBox(width: 10.0),
              Text(
                " Moderator DashBoard",
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
              SizedBox(width: 15.0),
              Icon(
                Icons.verified,
                color: Colors.orange,
                size: 30.0,
              ),
            ]),

            // Text("The value is $_switch"),
            //
            SizedBox(height: 30.0),

            //To tell the moderator to continue marking questions and answers
            // num = countDocuments();
            //I want to show the progress of the marking
            SleekCircularSlider(
              initialValue: count.toDouble(),
              max: 100,
            ),

            Text("$count QUESTIONS RECENTLY ASKED"),
            _switch
                ? SizedBox(
                    width: 250.0,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Agne',
                        color: Colors.white70,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText('VIEW ALL QUESTIONS'),
                          TypewriterAnimatedText(
                              'ENSURE THAT QUESTIONS ARE APPROPRIATE'),
                          TypewriterAnimatedText(
                              'DELETE INAPPROPRIATE QUESTIONS'),
                        ],
                        totalRepeatCount: 5,
                        pause: const Duration(milliseconds: 1000),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  )
                : SizedBox(
                    width: 250.0,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Agne',
                        color: Colors.grey,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText('VIEW ALL QUESTIONS'),
                          TypewriterAnimatedText(
                              'ENSURE THAT QUESTIONS ARE APPROPRIATE'),
                          TypewriterAnimatedText(
                              'DELETE INAPPROPRIATE QUESTIONS'),
                        ],
                        totalRepeatCount: 5,
                        pause: const Duration(milliseconds: 1000),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  ),
            //for space between the sliders
            SizedBox(height: 30.0),
            //Another slider to show how many questions are marked
            SleekCircularSlider(
              initialValue: count.toDouble(),
              max: 100,
            ),

            Text("$count QUESTIONS MARKED"),
            _switch
                ? SizedBox(
                    width: 250.0,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Agne',
                        color: Colors.white70,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText('VIEW ANSWERS TO QUESTIONS'),
                          TypewriterAnimatedText(
                              'ENSURE THAT ANSWERS ARE CORRECT'),
                          TypewriterAnimatedText('MARK ANSWERS'),
                        ],
                        totalRepeatCount: 5,
                        pause: const Duration(milliseconds: 1000),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  )
                : SizedBox(
                    width: 250.0,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Agne',
                        color: Colors.grey,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText('VIEW ANSWERS TO QUESTIONS'),
                          TypewriterAnimatedText(
                              'ENSURE THAT ANSWERS ARE CORRECT'),
                          TypewriterAnimatedText('MARK ANSWERS'),
                        ],
                        totalRepeatCount: 5,
                        pause: const Duration(milliseconds: 1000),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                        onTap: getUserName,
                      ),
                    ),
                  ),

            SizedBox(
              height: 30.0,
            ),
            Row(children: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              Card(
                color: Colors.grey[400],
                child: Column(children: <Widget>[
                  const SizedBox(
                    height: 50,
                    width: 160,
                  ),
                  Row(
                    children: <Widget>[
                      Column(children: <Widget>[
                        Text(" Question Ninjas:"),
                        Icon(Icons.diamond, color: Colors.amber),
                        Text(">5 Questions"),
                      ]),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                    width: 160,
                  ),
                ]),
              ),
              Card(
                color: Colors.grey[400],
                child: Column(children: <Widget>[
                  const SizedBox(
                    height: 50,
                    width: 160,
                  ),
                  Row(
                    children: <Widget>[
                      Column(children: <Widget>[
                        Text(" Thoughtful Observers:"),
                        Icon(Icons.diamond),
                        Text("<=5 Questions"),
                      ]),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                    width: 160,
                  ),
                ]),
              ),
            ]),
            //Add a card at the end that will show how regular users get their achievements
          ]),
        ),
      ),
    );
  }

  //to write how many questions have been asked
}
