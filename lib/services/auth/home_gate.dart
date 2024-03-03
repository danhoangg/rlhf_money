import 'package:flutter/material.dart';
import 'package:rlhf_money/pages/main_page.dart';
import 'package:rlhf_money/pages/profile_page.dart';
import 'package:rlhf_money/pages/wallet_page.dart';

class HomeGate extends StatefulWidget {
  const HomeGate({super.key});

  @override
  State<HomeGate> createState() => _HomeGateState();
}

class _HomeGateState extends State<HomeGate> {
  int page_index = 0;

  void setPageIndex(int index) {
    setState(() {
      page_index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (page_index) {
      case 0:
        return MainPage(setPageIndex: setPageIndex);
      case 1:
        return WalletPage(setPageIndex: setPageIndex);
      case 2:
        return ProfilePage(setPageIndex: setPageIndex);
      default:
        return MainPage(setPageIndex: setPageIndex);
    }
  }
}
