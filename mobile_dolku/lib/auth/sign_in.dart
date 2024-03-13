import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_dolku/components/component.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void _login({required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Component.showLoading(context);
      Navigator.pushReplacementNamed(context, '/home');
      Component.showSnackbar(
          message: 'Welcome back', color: Colors.green, context: context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Component.showSnackbar(
            message: 'User not found', color: Colors.red, context: context);
      }

      if (e.code == 'wrong-password') {
        Component.showSnackbar(
            message: 'Wrong password', color: Colors.red, context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Sign In'),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Belum punya akun?',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary)),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/sign_up'),
                    child: Text('Sign Up',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary)),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () => setState(() => _login(
                      email: emailController.text,
                      password: passwordController.text)),
                  child: const Text('Sign Up')),
            ],
          ),
        ),
      ),
    );
  }
}
