import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rlhf_money/components/my_button.dart';
import 'package:rlhf_money/components/my_textfield.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final _cashTextController = new TextEditingController();

  void cashOut() async {}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE0E1DD),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(right: 10, top: 10),
                  
                  decoration: BoxDecoration(
                    color: const Color(0xff778DA9),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 24,
                      ),
                      Text('£2.60', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white,),),
                    ],
                  )
              )],
            ),
            Container(
              margin: const EdgeInsets.all(40),
              padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: [
                  const Text('Balance: £2.60', style: TextStyle(fontSize: 36)),
                  const Text('Minimum cash out: £5', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  Container(
                    padding: EdgeInsets.only(top: 30, bottom: 50),
                    child: MyTextField(
                      controller: _cashTextController,
                      labelText: '',
                      hintText: 'Withdrawl amount',
                      obscureText: false,
                    ),
                  ),
                  MyButton(text: 'Cash Out', icon: Icons.attach_money, onPressed: cashOut)
                ],
              ),
            )
          ],
        ),
        
      )
    );
  }
}