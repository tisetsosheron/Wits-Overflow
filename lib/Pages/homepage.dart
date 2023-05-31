import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/Pages/MainQuestions.dart';
import 'package:wits_overflow/Pages/ProfileEdit.dart';
import 'package:wits_overflow/Pages/signin.dart';
import 'package:wits_overflow/Pages/MderatorPage.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final user = FirebaseAuth.instance.currentUser!;
  bool _switch = false;
  int count = 0;
  ThemeData _dark = ThemeData(brightness: Brightness.dark);
  ThemeData _light = ThemeData(brightness: Brightness.light);

  bool rewards(int count) {
    if (count > 5) {
      return false;
    }
    return true;
  }

  void answer(String username) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CounterScreenState(currentUser: username),
    ));
  }

  Future getUserName() async {
    final user = FirebaseAuth.instance.currentUser;

    String username = "";

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
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('questions');

    QuerySnapshot snapshot = await collectionRef.get();
    count = snapshot.size;
    return count;
  }

  Future<bool> calculateRewards(int count) async {
    // Perform the necessary calculations for rewards based on the count
    // Example logic:
    if (count > 5) {
      return false;
    }
    return true;
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
        appBar: _switch
            ? AppBar(backgroundColor: Colors.purple[200])
            : AppBar(backgroundColor: Colors.blueGrey),
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
                leading: Switch(
                    value: _switch,
                    onChanged: (
                      _newvalue,
                    ) {
                      setState(() {
                        _switch = _newvalue;
                      });
                    }),
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
                  // toprofile();
                },
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              // child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    _switch
                        ? Text("DashBoard",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,

                              //light mode text
                            ))
                        : Text("DashBoard",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            )),

                    SizedBox(
                      width: 70.0,
                    ),

                    //const Icon(Icons.menu, color: Colors.black, size: 50.0),
                    FutureBuilder<int>(
                      future: countDocuments(),
                      builder: (BuildContext context,
                          AsyncSnapshot<int> countSnapshot) {
                        if (countSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (countSnapshot.hasError) {
                          return Text('Error: ${countSnapshot.error}');
                        } else {
                          count = countSnapshot.data ?? 0;
                          return FutureBuilder<bool>(
                            future: calculateRewards(count),
                            builder: (BuildContext context,
                                AsyncSnapshot<bool> rewardsSnapshot) {
                              if (rewardsSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (rewardsSnapshot.hasError) {
                                return Text('Error: ${rewardsSnapshot.error}');
                              } else {
                                bool hasRewards = rewardsSnapshot.data ?? false;
                                return Card(
                                  child: Column(
                                    children: [
                                      rewards(count)
                                          ? Icon(Icons.sunny,
                                              color: Colors.blueGrey,
                                              size: 35.0)
                                          : Icon(Icons.diamond_outlined,
                                              color: Colors.amber, size: 35.0),
                                    ],
                                  ),
                                );
                              }
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 70.0,
                ),
                SizedBox(
                  width: 50.0,
                ),
                Center(
                  child: Row(
                    children: <Widget>[
                      //the questions and answers card
                      SizedBox(
                          width: 159.0,
                          height: 159.0,
                          child: Card(
                              color: Colors.blueGrey,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: getUserName,
                                  child: Column(
                                    children: [
                                      Image.asset("images/list.png",
                                          width: 64.0),

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
                      FutureBuilder<int>(
                        future: countDocuments(),
                        builder: (BuildContext context,
                            AsyncSnapshot<int> countSnapshot) {
                          if (countSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (countSnapshot.hasError) {
                            return Text('Error: ${countSnapshot.error}');
                          } else {
                            count = countSnapshot.data ?? 0;
                            return FutureBuilder<bool>(
                              future: calculateRewards(count),
                              builder: (BuildContext context,
                                  AsyncSnapshot<bool> rewardsSnapshot) {
                                if (rewardsSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (rewardsSnapshot.hasError) {
                                  return Text(
                                      'Error: ${rewardsSnapshot.error}');
                                } else {
                                  bool hasRewards =
                                      rewardsSnapshot.data ?? false;
                                  return Card(
                                    color: Colors.blueGrey,
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          rewards(count)
                                              ? Icon(Icons.sunny,
                                                  color: Colors.white70,
                                                  size: 55.0)
                                              : Icon(Icons.diamond_outlined,
                                                  color: Colors.amber,
                                                  size: 55.0),
                                          const SizedBox(height: 25.0),
                                          rewards(count)
                                              ? Text(
                                                  "THOUGHFUL OBSERVER",
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.white70),
                                                )
                                              : Text(
                                                  "QUESTION NINJA",
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.white70),
                                                ),
                                          const Text(
                                            "Achievements",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          const SizedBox(height: 5.0),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(Dashboard());
}
