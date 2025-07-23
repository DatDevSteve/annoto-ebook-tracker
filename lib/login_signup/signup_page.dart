import 'package:annoto/login_signup/custom_appbar.dart';
import 'package:annoto/screen_manager.dart';
import 'package:annoto/login_signup/login_page.dart';
import 'package:annoto/ui_elements/transitions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwdController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwdController.dispose();
    super.dispose();
  }

  Future<void> createUserWithEmailPasswd() async {
    final email = _emailController.text.trim();
    final password = _passwdController.text.trim();

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //print(userCredential);
      Navigator.of(context).pushReplacement(transitionPage(() => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (email == "" || password == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter a valid Email ID or Password")),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('${e.message}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: authAppBar(title: "ANNOTO"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: double.infinity, height: 250),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxHeight: screenHeight - 300),
                width: 500,
                child: Card(
                  margin: EdgeInsets.all(10),
                  elevation: 10,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(35),
                      bottom: Radius.circular(35),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //SizedBox(height: 2),
                          Text(
                            'SIGN UP',
                            style: GoogleFonts.inriaSans(
                              color: Color.fromRGBO(7, 113, 55, 1),
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 5,
                            ),
                          ),
                          Text(
                            " to create your e-book library",
                            style: textTheme.bodySmall,
                          ),
                          SizedBox(height: 20),
                          TextField(
                            style: TextStyle(color: Colors.black, fontSize: 20),
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: "Enter Email Address",
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            style: TextStyle(color: Colors.black, fontSize: 20),
                            controller: _passwdController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Enter Password",
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                backgroundColor: Color.fromRGBO(7, 113, 55, 1),
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () async {
                                await createUserWithEmailPasswd();
                              },
                              child: Text(
                                "Sign Up",
                                style: textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          SizedBox(height: 3),
                          Center(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Color.fromRGBO(7, 113, 55, 1),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  transitionPage(() => LoginPage()),
                                );
                              },
                              child: Text(
                                "Already have an account? Log In",
                                style: TextStyle(
                                  color: Color.fromRGBO(7, 113, 55, 1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
