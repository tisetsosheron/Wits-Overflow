import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/Pages/homepage.dart';
import 'package:wits_overflow/Pages/register.dart';

import 'ResetPassword.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


//This function is responsible for routing the user to different pages based on their role in the database.


  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('registeredUsers')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {

        //If the role is moderator, it navigates to the moderator home page
        if (documentSnapshot.get('role') == "rolesEnum.Moderator") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  const ResetPassword(),// will change this when we have the moderator homepage
            ),
          );
        }else{
          ////If the role is regular page, it navigates to the regular user dashboard

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  Dashboard(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }


  Future signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      if (mounted) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        route();

      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      ErrorMessage(e.code);
    }
  }

  //error message popup
  void ErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(image: AssetImage('images/WITS.png')),
                  const SizedBox(
                    height: 15,
                  ),
                  //email textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: 'Email'),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  //password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                        //Colour of the boxes for homepage
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: 'Password'),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  //sign in button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: signIn,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.blue, fontSize: 17),
                        ),
                        onTap: resetpassword,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  //or continue wih google
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),

                  SingleChildScrollView(
                      child: Column(children: [
                    Image.asset(
                      "images/google.jpg",
                      width: 40,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ])),

                  //if not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not a member?',
                        style:
                            TextStyle(color: Color.fromARGB(255, 97, 97, 97)),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: registerpage,
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )

                  //not a member? register now
                ],
              ),
            ),
          ),
        ));
  }

  void resetpassword() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ResetPassword(),
    ));
  }

  void registerpage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Register(onTap: () {}),
    ));
  }
}
