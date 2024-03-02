import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rlhf_money/components/my_button.dart';
import 'package:rlhf_money/components/my_textfield.dart';
import 'package:provider/provider.dart';
import 'package:rlhf_money/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function() onPressed;
  const LoginPage({super.key, required this.onPressed});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 225, 221),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 150),
              const Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 36),
              ),
              const SizedBox(height: 20),
              const Text('Ready to earn some mindbucks?'),
              const SizedBox(height: 60),
              MyTextField(
                labelText: 'Enter your email',
                obscureText: false,
                hintText: 'example@payoutmind.com',
                controller: emailController,
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                labelText: 'Enter your password',
                obscureText: true,
                hintText: 'Password',
                controller: passwordController,
              ),
              const SizedBox(
                height: 40,
              ),
              MyButton(
                text: 'Login',
                icon: Icons.login_outlined,
                onPressed: login,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: widget.onPressed,
                    child: const Text(
                      'Sign up!',
                      style: TextStyle(color: Color(0xff1b263b)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
