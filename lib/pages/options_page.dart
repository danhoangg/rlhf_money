import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rlhf_money/components/my_button.dart';
import 'package:rlhf_money/services/auth/model_service.dart';
import 'package:rlhf_money/services/auth/rewards_service.dart';

class OptionsPage extends StatefulWidget {
  final String id;
  final String name;
  const OptionsPage({super.key, required this.id, required this.name});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  final PageController _pageController = PageController();
  final List<int> _selectedResponses = [];

  // update user balance
  void finishSurvey() {
    final modelService = Provider.of<RewardsService>(context, listen: false);
    modelService.finishSurvey(widget.id);

    Navigator.pop(context);
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

  void _addResponse(int responseIndex) {
    _selectedResponses.add(responseIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE0E1DD),
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: const Color(0xffE0E1DD),
      ),
      body: _buildQuestionList(),
    );
  }

  Widget _buildQuestionList() {
    return StreamBuilder<QuerySnapshot>(
      stream: Provider.of<ModelService>(context).fetchQuestions(widget.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        final questions = snapshot.data!.docs;
        return PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ...questions.map(
              (question) => QuestionItem(
                prompt: question['prompt'],
                responses: List.from(question['responses']),
                nextPage: _nextPage,
                addResponse: _addResponse,
              ),
            ),
            _buildFinalPage()
          ],
        );
      },
    );
  }

  Widget _buildFinalPage() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              children: [
                Text(
                  'You\'re all done!',
                  style: TextStyle(fontSize: 28),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Just click the button below and claim your rewards!')
              ],
            ),
            MyButton(
              text: 'Claim rewards',
              icon: Icons.check,
              onPressed: finishSurvey,
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionItem extends StatefulWidget {
  final String prompt;
  final List<dynamic> responses;
  final Function() nextPage;
  final Function(int) addResponse;

  const QuestionItem({
    Key? key,
    required this.prompt,
    required this.responses,
    required this.nextPage,
    required this.addResponse,
  }) : super(key: key);

  @override
  _QuestionItemState createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  int _responseIndex = 0;

  void _nextResponse() {
    setState(() {
      _responseIndex = (_responseIndex + 1) % widget.responses.length;
    });
  }

  void _previousResponse() {
    setState(() {
      _responseIndex = (_responseIndex - 1 + widget.responses.length) %
          widget.responses.length;
    });
  }

  void _chooseResponse() {
    widget.addResponse(_responseIndex);
    widget.nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          Text(
            'Prompt: ${widget.prompt}',
            style: const TextStyle(
                fontSize: 18,
                color: Color(0xff0D1B2A),
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Response: ${_responseIndex + 1}/${widget.responses.length}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xff0D1B2A),
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.responses[_responseIndex],
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xff1B263B),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: _previousResponse,
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: _nextResponse,
              ),
            ],
          ),
          const SizedBox(height: 60),
          MyButton(
            text: "Choose this response?",
            icon: Icons.arrow_forward,
            onPressed: _chooseResponse,
          ),
        ],
      ),
    );
  }
}
