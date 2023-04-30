import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wits_overflow/homepage.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:wits_overflow/signin.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:wits_overflow/register.dart';

void main() {
  group('Register widget', () {
    late Register register;

    setUp(() {
      register = const Register(onTap: null);
    });

    testWidgets('has an email text field', (tester) async {
      await tester.pumpWidget(register);

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.widgetWithText(TextField, 'email address'), findsOneWidget);
    });

    testWidgets('has a password text field', (tester) async {
      await tester.pumpWidget(register);

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
    });

    testWidgets('has a confirm password text field', (tester) async {
      await tester.pumpWidget(register);

      expect(find.byType(TextField), findsNWidgets(2));
      expect(
          find.widgetWithText(TextField, 'Confirm Password'), findsOneWidget);
    });

    testWidgets('typing in the email field updates the controller value',
        (tester) async {
      await tester.pumpWidget(register);

      const email = 'test@example.com';
      await tester.enterText(
          find.widgetWithText(TextField, 'email address'), email);

      expect(register._emailController.text, equals(email));
    });

    testWidgets('typing in the password field updates the controller value',
        (tester) async {
      await tester.pumpWidget(register);

      const password = 'password';
      await tester.enterText(
          find.widgetWithText(TextField, 'Password'), password);

      expect(register._passwordController.text, equals(password));
    });

    testWidgets(
        'typing in the confirm password field updates the controller value',
        (tester) async {
      await tester.pumpWidget(register);

      const password = 'password';
      await tester.enterText(
          find.widgetWithText(TextField, 'Confirm Password'), password);

      expect(register._confirmPasswordController.text, equals(password));
    });
  });
}

enum rolesEnum { Moderator, RegularUser }

class Register extends StatefulWidget {
  final void Function()? onTap;
  const Register({super.key, required this.onTap});

  get _emailController => null;

  get _passwordController => null;

  get _confirmPasswordController => null;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  rolesEnum? _rolesEnum;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future Register() async {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        Fluttertoast.showToast(
            msg: "Successfully Registered!", //Show message
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 10,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 15);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginPage(
            onTap: () {},
          ),
        ));
      } on FirebaseAuthException catch (e) {
        if (e.code == "invalid-email") {
          //Incorrect Email Format
          invalidEmail();
        } else if (e.code == "weak-password") {
          //Password too easy to guess
          weakPassword();
        } else if (e.code == "email-already-in-use") {
          //Already existing email
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text('Email Already in use'),
              );
            },
          );
        }
      }
    } else {
      WrongConfirmPassword();
    }
  }

  void WrongConfirmPassword() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Passwords do not match'),
        );
      },
    );
  }

  void invalidEmail() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Invalid Email'),
        );
      },
    );
  }

  void weakPassword() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Weak Password'),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                            controller: _emailController,
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
                            controller: _passwordController,
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
                            controller: _confirmPasswordController,
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
                        onTap: signin,
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

  void signin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LoginPage(onTap: () {})),
    );
  }
}
