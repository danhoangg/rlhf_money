import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rlhf_money/components/my_button.dart';
import 'package:rlhf_money/components/my_textfield.dart';
import 'package:rlhf_money/services/auth/user_info_service.dart';

class ProfilePage extends StatefulWidget {
  final Function(int) setPageIndex;
  final int currentPageIndex = 2;
  const ProfilePage({
    super.key,
    required this.setPageIndex,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _pageController = PageController();

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

  void changeName() {
    final userInfoService =
        Provider.of<UserInfoService>(context, listen: false);

    try {
      userInfoService.changeName(
          _firstNameController.text, _lastNameController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void changeEmail() {
    final userInfoService =
        Provider.of<UserInfoService>(context, listen: false);

    try {
      userInfoService.changeEmail(_emailController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void changePassword() {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final userInfoService =
        Provider.of<UserInfoService>(context, listen: false);

    try {
      userInfoService.changePassword(_passwordController.text);
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
      backgroundColor: Color(0xffE0E1DD),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          widget.setPageIndex(index);
        },
        indicatorColor: const Color(0xdd415A77),
        selectedIndex: widget.currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.account_balance_wallet),
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Wallet',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.account_circle),
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Developers',
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xffE0E1DD),
      ),
      body: _buildProfile(),
    );
  }

  Widget _buildProfile() {
    // userinfo service
    final userInfoService =
        Provider.of<UserInfoService>(context, listen: false);

    return StreamBuilder(
      stream: userInfoService.getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: const Color(0xffE0E1DD),
            child: const CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        final model = snapshot.data!;

        return SafeArea(
            child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildName(model, _previousPage, _nextPage),
            _buildEmail(model, _previousPage, _nextPage),
            _buildPassword(model, _previousPage, _nextPage),
          ],
        ));
      },
    );
  }

  Widget _buildName(model, prevPage, nextPage) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
      child: Center(
        child: Column(
          children: [
            Text(
              'Hi ${model['firstName']}, how are you doing?',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            MyTextField(
              controller: _firstNameController,
              labelText: model['firstName'],
              hintText: 'Change your first name',
              obscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: _lastNameController,
              labelText: model['lastName'],
              hintText: 'Change your last name',
              obscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: prevPage,
                ),
                const SizedBox(
                  width: 20,
                ),
                MyButton(
                    text: 'Change name?',
                    icon: Icons.edit,
                    onPressed: changeName),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: nextPage,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmail(model, prevPage, nextPage) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
      child: Center(
        child: Column(
          children: [
            Text(
              'Hi ${model['firstName']}, how are you doing?',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            MyTextField(
              controller: _emailController,
              labelText: model['email'],
              hintText: 'Change your email',
              obscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: prevPage,
                ),
                const SizedBox(
                  width: 20,
                ),
                MyButton(
                    text: 'Change email?',
                    icon: Icons.edit,
                    onPressed: changeEmail),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: nextPage,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPassword(model, prevPage, nextPage) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
      child: Center(
        child: Column(
          children: [
            Text(
              'Hi ${model['firstName']}, how are you doing?',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            MyTextField(
              controller: _passwordController,
              labelText: 'Password',
              hintText: 'Change your password',
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: _confirmPasswordController,
              labelText: 'Confirm Password',
              hintText: 'Re enter your password',
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: prevPage,
                ),
                const SizedBox(
                  width: 20,
                ),
                MyButton(
                    text: 'Change password?',
                    icon: Icons.edit,
                    onPressed: changePassword),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: nextPage,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
