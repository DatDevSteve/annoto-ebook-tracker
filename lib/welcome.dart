import 'package:annoto/login_signup/login_page.dart';
import 'package:annoto/login_signup/signup_page.dart';
import 'package:annoto/ui_elements/transitions.dart' show transitionPage;
import 'package:flutter/material.dart';
import 'package:annoto/login_signup/custom_appbar.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
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
                //constraints: BoxConstraints(maxHeight: screenHeight - 300),
                width: 550,
                height: screenHeight - 350,
                child: Card(
                  elevation: 10,
                  //margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(35),
                      //bottom: Radius.circular(35),
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
                          //SizedBox(height: 50),
                          Center(
                            child: Text(
                              'WELCOME',
                              style: GoogleFonts.inriaSans(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 5,
                              ),
                            ),
                          ),
                          SizedBox(height: 50),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.fromLTRB(90, 10, 90, 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                backgroundColor: Color.fromRGBO(7, 113, 55, 1),
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () async {
                                Navigator.of(context).pushReplacement(
                                  transitionPage(() => LoginPage()),
                                );
                              },
                              child: Text(
                                "SIGN IN",
                                style: GoogleFonts.inriaSans(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 5,
                              ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
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
