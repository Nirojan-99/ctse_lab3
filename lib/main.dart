import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Screens/login.dart';
import 'package:recipe_app/Screens/recipe_details.dart';
import 'package:recipe_app/Screens/recipe_list.dart';
import 'package:recipe_app/Screens/signup.dart';
import 'package:recipe_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      primaryColor: Colors.purple,
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: themeData,
      routes: {
        "/login": (context) => const LoginScreen(),
        "/register": (context) => const RegisterScreen(),
        "/recipes": (context) => const RecipeList(),
        "/recipe": (context) => const RecipeDetails(),
      },
      home: const LoginScreen(),
    );
  }
}
