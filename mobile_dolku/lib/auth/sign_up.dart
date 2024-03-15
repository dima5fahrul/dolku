// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_dolku/components/component.dart';

import '../components/common_button.dart';
import '../components/common_form.dart';

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
    var primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: Text('Sign up',
                      style: Theme.of(context).textTheme.displaySmall)),
              const SizedBox(height: 40),
              Text('Name',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.w400)),
              const SizedBox(height: 8),
              CommonForm(
                  controller: nameController,
                  focusedColor: primaryColor,
                  hintText: 'Enter your name'),
              const SizedBox(height: 16),
              Text('E-mail',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.w400)),
              const SizedBox(height: 8),
              CommonForm(
                  controller: emailController,
                  focusedColor: primaryColor,
                  hintText: 'Enter your email'),
              const SizedBox(height: 16),
              Text('Password',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.w400)),
              const SizedBox(height: 8),
              CommonForm(
                  controller: passwordController,
                  focusedColor: primaryColor,
                  isPassword: true,
                  hintText: 'Enter your password'),
              const SizedBox(height: 50),
              CommonButton(
                  text: 'Sign up', borderColor: primaryColor, onTap: _signUp),
              const SizedBox(height: 8),
              CommonButton(
                  withBorder: false,
                  text: 'Sign in',
                  onTap: () => Navigator.pop(context)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('By signing up, you agree to our ',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Colors.grey.shade600)),
                  Text('Terms & Conditions',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: primaryColor)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
