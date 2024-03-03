import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rlhf_money/firebase_options.dart';
import 'package:rlhf_money/services/auth/auth_gate.dart';
import 'package:rlhf_money/services/auth/auth_service.dart';
import 'package:rlhf_money/services/auth/model_service.dart';
import 'package:rlhf_money/services/auth/rewards_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => ModelService()),
        ChangeNotifierProvider(create: (context) => RewardsService())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'rlhf',
      home: AuthGate(),
    );
  }
}
