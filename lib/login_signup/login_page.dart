import 'package:google_fonts/google_fonts.dart';
import 'package:annoto/login_signup/custom_appbar.dart';
import 'package:annoto/screen_manager.dart';
import 'package:annoto/login_signup/signup_page.dart';
import 'package:annoto/ui_elements/transitions.dart';
// Removed: import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwdController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwdController.dispose();
    super.dispose();
  }

  Future<void> loginEmailPasswd() async {}

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
                height: screenHeight - 350,
                child: Card(
                  elevation: 10,
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
                            'SIGN IN',
                            style: GoogleFonts.inriaSans(
                              color: Color.fromRGBO(7, 113, 55, 1),
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 5,
                            ),
                          ),
                          Text(
                            " to access your e-book library",
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
                                final supabase = Supabase.instance.client;
                                final email = _emailController.text.trim();
                                final password = _passwdController.text.trim();

                                if (email == "" || password == "") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Please enter a valid Email ID or Password",
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                try {
                                  final AuthResponse response = await supabase
                                      .auth
                                      .signInWithPassword(
                                        password: password,
                                        email: email,
                                      );
                                  if (response.session != null) {
                                    
                                    Navigator.of(context).pushReplacement(
                                      transitionPage(() => HomeScreen()),
                                    );
                                    
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(e.toString()),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "Sign In",
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
                                  transitionPage(() => SignupPage()),
                                );
                              },
                              child: Text(
                                "Create a New Account",
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
