import 'package:app/screens/login.dart';
import 'package:app/screens/main_screen.dart';
import 'package:app/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (FirebaseAuth.instance.currentUser != null &&
          FirebaseAuth.instance.currentUser!.emailVerified) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text("See you later!"),
        //   ),
        // );
        print('User signed in!');
      } else if (!FirebaseAuth.instance.currentUser!.emailVerified) {
        print('Wating for verification!');
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text("Welcome Back!"),
        //   ),
        // );
        print('User is currently signed out!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coffee Shop',
        theme: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(210, 111, 78, 55),
          secondary:
              const Color.fromARGB(210, 236, 177, 118), //rgb(236, 177, 118)
        )),
        home: (FirebaseAuth.instance.currentUser != null &&
                FirebaseAuth.instance.currentUser!.emailVerified)
            ? const MainScreen()
            : const Login(),
        routes: {
          "signUp": (context) => const SignUp(),
          "Login": (context) => const Login(),
          "Homepage": (context) => const MainScreen(),
        });
  }
}
