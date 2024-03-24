import 'package:flutter/material.dart';
import 'package:mobile_dolku/auth/sign_in.dart';
import 'package:mobile_dolku/auth/sign_up.dart';
import 'package:mobile_dolku/auth/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_dolku/firebase_options.dart';
import 'package:mobile_dolku/screen/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          fontFamily: 'Poppins',
          useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const ChatScreen(),
        '/sign_in': (context) => const SignIn(),
        '/sign_up': (context) => const SignUp(),
      },
    );
  }
}
