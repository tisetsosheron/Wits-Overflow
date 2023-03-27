import 'package:flutter/material.dart';
import 'package:wits_overflow/homepage.dart';

enum rolesEnum { Moderator, Participant }

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  rolesEnum? _rolesEnum;
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
                        child: const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: TextField(
                            decoration: InputDecoration(
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
                        child: const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: 'Password'),
                          ),
                        )),
                  ),
                  //email textfield

                  //confirm password textfield
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
                        child: const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Confirm Password'),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
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
                              value: rolesEnum.Participant,
                              groupValue: _rolesEnum,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              title: Text(rolesEnum.Participant.name),
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
                            'Sign up',
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
                        //onTap: widget.onTap,
                        child: const Text(
                          'Login here',
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

  void Register() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Dashboard(),
    ));
  }

  // void resetpassword() {
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => //reset_page,
  //   ));

  // }
}
