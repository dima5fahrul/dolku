// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_dolku/components/component.dart';

import '../components/common_button.dart';
import '../components/common_form.dart';

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
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacementNamed(context, '/home');
      Component.showSnackbar(
          message: 'Welcome back', color: Colors.green, context: context);
    } on FirebaseAuthException catch (e) {
      debugPrint('e : ${e.code}');
      Component.showLoading(context);
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pop(context);
      if (e.code == 'invalid-email') {
        Component.showSnackbar(
            message: 'Invalid email', color: Colors.red, context: context);
      }

      if (e.code == 'invalid-credential') {
        Component.showSnackbar(
            message: 'Invalid credential', color: Colors.red, context: context);
      }

      if (e.code == 'channel-error') {
        Component.showSnackbar(
            message: 'Form must be filled',
            color: Colors.red,
            context: context);
      }
    }
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
                  child: Text(
                'Sign in',
                style: Theme.of(context).textTheme.displaySmall,
              )),
              const SizedBox(height: 40),
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
                  hintText: 'Enter your password',
                  isPassword: true),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => Navigator.pushNamed(context, '/sign_up'),
                  child: Ink(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text('Forgot your password?',
                        textAlign: TextAlign.right,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: Colors.grey.shade500)),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              CommonButton(
                text: 'Sign in',
                borderColor: primaryColor,
                onTap: () => _login(
                    email: emailController.text,
                    password: passwordController.text),
              ),
              const SizedBox(height: 8),
              CommonButton(
                text: 'Sign up',
                withBorder: false,
                onTap: () => Navigator.pushNamed(context, '/sign_up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
