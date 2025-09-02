import 'package:annoto/firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:annoto/screen_manager.dart';
import 'package:annoto/login_signup/login_page.dart';
import 'package:annoto/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:annoto/ui_elements/theme.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:annoto/library_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //await FirebaseAuth.instance.signOut(); //Debugging: Sign out user on app start

  // Conditional block to make necessary changes on web platform compatibility
  if (!kIsWeb) {
    final dir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  } else {
    await Hive.initFlutter(); // Web uses IndexedDB
  }
  Hive.registerAdapter(LibStoreAdapter());
  
  //await Hive.deleteBoxFromDisk('ebooks'); //DANGEROUS, ONLY FOR DEBUGGING: Deletes all stored eBooks, use with caution

  try {
  if (!Hive.isBoxOpen('ebooks')) {
    await Hive.openBox<LibStore>('ebooks');
  }
} catch (e, stacktrace) {
  debugPrint('Hive openBox error: $e');
  debugPrint('$stacktrace');
}


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      title: "Annoto eBook Library",
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (asyncSnapshot.hasData) {
            return HomeScreen();
          }
          if (asyncSnapshot.data == null) {
            return WelcomePage();
          }
          if (asyncSnapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Unexpected Error, Please Log in again")),
            );
            return LoginPage();
          }
          return WelcomePage();
        },
      ),
    );
  }
}
