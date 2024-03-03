import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rlhf_money/firebase_options.dart';
import 'package:rlhf_money/pages/main_page.dart';
import 'package:rlhf_money/pages/profile_page.dart';
import 'package:rlhf_money/pages/wallet_page.dart';
import 'package:rlhf_money/services/auth/auth_gate.dart';
import 'package:rlhf_money/services/auth/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'rlhf',
      home: MainPage(),
    );
  }
}
