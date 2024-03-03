import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rlhf_money/components/my_button.dart';
import 'package:rlhf_money/services/auth/user_info_service.dart';

class DevPage extends StatefulWidget {
  final void Function(int) setPageIndex;
  final int currentPageIndex = 3;
  const DevPage({super.key, required this.setPageIndex});

  @override
  State<DevPage> createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
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
      body: SafeArea(
        child: Center(
          child: MyButton(
            text: "Register new Model",
            icon: Icons.app_registration_rounded,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
