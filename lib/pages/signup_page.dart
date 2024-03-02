import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rlhf_money/components/my_button.dart';
import 'package:rlhf_money/components/my_textfield.dart';
import 'package:rlhf_money/services/auth/auth_service.dart';

class SignUpPage extends StatefulWidget {
  final void Function() onPressed;
  const SignUpPage({super.key, required this.onPressed});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final PageController _pageController = PageController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  void signUp(bool dev) {
    // firebase auth instance
    final _auth = Provider.of<AuthService>(context, listen: false);

    try {
      _auth.registerWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
          _firstNameController.text,
          _lastNameController.text,
          dev);
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
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _showMoreInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Developer?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'As a developer you are able to pay to use our services to train and perfect your generative ai models.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe0e1dd),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildEmailPasswordPage(),
          _buildNamePage(),
          _buildDevQuestionPage(),
        ],
      ),
    );
  }

  Widget _buildEmailPasswordPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'New here?',
          style: TextStyle(fontSize: 36),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Let\'s get you set up!',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 80,
        ),
        MyTextField(
            controller: _emailController,
            labelText: 'Enter your email',
            hintText: 'example@payoutmind.com',
            obscureText: false),
        const SizedBox(
          height: 30,
        ),
        MyTextField(
            controller: _passwordController,
            labelText: 'Enter your password',
            hintText: 'Password',
            obscureText: true),
        const SizedBox(
          height: 30,
        ),
        MyButton(text: 'Next', icon: Icons.arrow_forward, onPressed: _nextPage),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Already have an account?'),
            TextButton(
              onPressed: widget.onPressed,
              child: const Text(
                'Login!',
                style: TextStyle(color: Color(0xff1b263b)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNamePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'What should we call you?',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 80,
        ),
        MyTextField(
            controller: _firstNameController,
            labelText: 'First name',
            hintText: 'Oleg',
            obscureText: false),
        const SizedBox(
          height: 30,
        ),
        MyTextField(
            controller: _lastNameController,
            labelText: 'Last name',
            hintText: 'Paska',
            obscureText: false),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButton(
                text: 'Back', icon: Icons.arrow_back, onPressed: _previousPage),
            const SizedBox(
              width: 30,
            ),
            MyButton(
              text: 'Mext',
              icon: Icons.arrow_forward,
              onPressed: _nextPage,
            ),
          ],
        )
      ],
    );
  }

  Widget _buildDevQuestionPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Are you a developer?',
          style: TextStyle(fontSize: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('What does that mean?'),
            TextButton(
              onPressed: () =>
                  _showMoreInfoDialog(context), // Call the dialog function here
              child: const Text(
                'Learn more',
                style: TextStyle(
                  color: Color(0xff1b263b),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 80,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButton(
                text: 'Yes', icon: Icons.check, onPressed: () => signUp(true)),
            const SizedBox(
              width: 40,
            ),
            MyButton(
              text: 'No',
              icon: Icons.close,
              onPressed: () => signUp(false),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        TextButton(
          onPressed: _previousPage,
          child: const Text(
            'Take me back!',
            style: TextStyle(color: Color(0xff1B263B)),
          ),
        )
      ],
    );
  }
}
