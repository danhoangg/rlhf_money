import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rlhf_money/pages/options_page.dart';
import 'package:rlhf_money/services/auth/auth_service.dart';
import 'package:rlhf_money/services/auth/model_service.dart';

class MainPage extends StatefulWidget {
  final Function(int) setPageIndex;
  final int currentPageIndex = 0;
  const MainPage({super.key, required this.setPageIndex});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void signOut() {
    // firebase auth instance
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE0E1DD),
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
        backgroundColor: const Color(0xffE0E1DD),
        title: const Text(
          'Your models',
          style: TextStyle(fontSize: 28),
        ),
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(child: _buildModelList()),
      ),
    );
  }

  Widget _buildModelList() {
    return StreamBuilder<QuerySnapshot>(
      stream: Provider.of<ModelService>(context).fetchModels(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        final models = snapshot.data!.docs;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: models
              .map(
                (model) => _buildModelListItem(
                  model['name'],
                  '£${model['question_count'] * 0.01}',
                  model.id,
                  List.from(model['completed']),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildModelListItem(
      String name, String price, String id, List<dynamic> completed) {
    //firebase auth instance
    final firebaseAuth = FirebaseAuth.instance;
    final currentId = firebaseAuth.currentUser!.uid;

    if (completed.contains(currentId)) {
      return Container();
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OptionsPage(id: id, name: name),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 20),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              decoration: const BoxDecoration(
                color: Color(0xff415A77),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Text(
                price,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
