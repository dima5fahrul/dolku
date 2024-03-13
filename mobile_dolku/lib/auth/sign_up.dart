import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_dolku/components/component.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      await _addUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Component.showSnackbar(
            message: 'The password provided is too weak.',
            color: Colors.red,
            context: context);
      }

      if (e.code == 'email-already-in-use') {
        Component.showSnackbar(
            message: 'The account already exists for that email.',
            color: Colors.red,
            context: context);
      }
    } catch (e) {
      debugPrint(e.toString());
      Component.showSnackbar(
          message: 'Something went wrong!',
          color: Colors.red,
          context: context);
    }
  }

  Future _addUser() {
    CollectionReference users = db.collection('users');

    return users.add({
      'name': nameController.text,
      'email': emailController.text,
    }).then((value) {
      Navigator.pushReplacementNamed(context, '/home');
      debugPrint("User Added");
    }).catchError((error) {
      debugPrint("Failed to add user: $error");
      Component.showSnackbar(
          message: 'Something went wrong!',
          color: Colors.red,
          context: context);
    });
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
              const Text('Sign Up'),
              TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nama')),
              TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email')),
              TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password')),
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
                onPressed: () => setState(() => _signUp()),
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
