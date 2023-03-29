import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/homepage.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

enum rolesEnum { Moderator, RegularUser }

class Register extends StatefulWidget {
  final void Function()? onTap;
  const Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  rolesEnum? _rolesEnum;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future Register() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      if (passwordController.text == confirmPasswordController) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      } else {
        //error message
        errorMessage("passwords don't match");
      }

      Navigator.pop(context);
     
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      errorMessage(e.code);
    }
  }

  //error message popup
  void errorMessage(String message) {
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

                  const Text(
                    "Create an account here",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(
                    height: 20,
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
                          padding: EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'email address'),
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
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: 'Password'),
                          ),
                        )),
                  ),

                  //confirm password textfield
                  const SizedBox(
                    height: 15,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Confirm Password'),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    width: 4,
                  ),

                  //radio button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: RadioListTile<rolesEnum>(
                              contentPadding: const EdgeInsets.all(0.0),
                              value: rolesEnum.Moderator,
                              groupValue: _rolesEnum,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              title: Text(
                                rolesEnum.Moderator.name,
                              ),
                              onChanged: (val) {
                                setState(() {
                                  _rolesEnum = val;
                                });
                              }),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: RadioListTile<rolesEnum>(
                              contentPadding: const EdgeInsets.all(0.0),
                              value: rolesEnum.RegularUser,
                              groupValue: _rolesEnum,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              title: Text(rolesEnum.RegularUser.name),
                              onChanged: (val) {
                                setState(() {
                                  _rolesEnum = val;
                                });
                              }),
                        ),
                      ],
                    ),
                  ),

                  //sign in button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: Register,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text(
                            'Register',
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
                    height: 40,
                  ),

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
                  const SizedBox(height: 30),

                  SingleChildScrollView(
                      child: Column(children: [
                    Image.asset(
                      "images/google.jpg",
                      width: 45,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ])),

                  //not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style:
                            TextStyle(color: Color.fromARGB(255, 97, 97, 97)),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  // void resetpassword() {
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => //reset_page,
  //   ));

  // }
}
