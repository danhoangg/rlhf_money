import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ],
      ),
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/profile_picture.jpg'), // Replace with your profile picture
            ),
            const SizedBox(height: 20),
            const Text(
              'user@example.com', // Replace with the user's email address
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                // Handle password change here
                // For example, you can navigate to a password change screen
              },
              child: const Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
