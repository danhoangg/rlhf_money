import 'package:flutter/material.dart';
import 'package:rlhf_money/components/my_button.dart';
import 'package:rlhf_money/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final void Function() onPressed;
  const LoginPage({super.key, required this.onPressed});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                  text: 'Login', icon: Icons.login_outlined, onPressed: () {}),
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
