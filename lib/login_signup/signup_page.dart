import 'package:annoto/login_signup/custom_appbar.dart';
import 'package:annoto/screen_manager.dart';
import 'package:annoto/login_signup/login_page.dart';
import 'package:annoto/ui_elements/transitions.dart';
// Removed: import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  // Removed Firebase signup logic
  Future<void> createUserWithEmailPasswd() async {
    final email = _emailController.text.trim();
    final password = _passwdController.text.trim();
    final auth = Supabase.instance.client.auth;

    // Placeholder for local signup logic or validation
    if (email == "" || password == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid Email ID or Password"), backgroundColor: Colors.red,),
      );
      return;
    }
     try {
      final AuthResponse response = await auth.signUp(password: password, email: email);
      if (response.session != null){
        Navigator.of(context).pushReplacement(transitionPage(() => HomeScreen()));
      }
      

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString(), selectionColor: Colors.red,)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AuthAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: double.infinity, height: 300),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 50, 5, 0),
            child: Center(
              child: Container(
                width: 550,
                height: screenHeight-350,
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(35),
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
