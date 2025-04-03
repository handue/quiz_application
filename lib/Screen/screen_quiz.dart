import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:quiz_app_test/model/model_quiz.dart';

import '../widget/widget_candidate.dart';

class QuizScreen extends StatefulWidget {
  List<Quiz> quizs;

  QuizScreen({super.key, required this.quizs});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<int> _answers = [-1, -1, -1];
  final List<bool> _answerState = [false, false, false, false];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.deepPurple),
            ),
            width: width * 0.85,
            height: height * 0.5,
            child: Swiper(
              //이게 swiper 애니메이션 작동하는거, 그니까 화면 넘기는거 했을 때 화면 넘길 수 있도록 하는거
              //핸드폰 쓰면 그거 있잖아, 손으로 넘길수 있는 기능 ,그거 해주는거 같고
              physics:
                  const NeverScrollableScrollPhysics(), // 이거는 스와이프 비활성화, 사용자가 수동으로 스와이프하거나 스크롤 할 수 없게 만드는거. 이렇게 금지해버리면 swiper는 사용자가 사용할 수 없지만, 내가 애니메이션 기능으론 사용할 수 있음.
              loop:
                  false, // 원래 loop가 true라면 Swiper의 마지막 항목에서 또 스와이프 하면 처음으로 돌아가지만 false하면 처음으로 다시 안 돌아옴.
              itemCount: widget.quizs.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildQuizCard(widget.quizs[index], width, height);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard(Quiz quiz, double width, double height) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, width * 0.024, 0, width * 0.024),
            child: Text(
              'Q${_currentIndex + 1}.',
              style: TextStyle(
                fontSize: width * 0.08,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: width * 0.8,
            padding: EdgeInsets.only(top: width * 0.05),
            child: AutoSizeText(
              quiz.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: width * 0.048,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Column(
            children: _buildCandidates(width, quiz),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCandidates(double width, Quiz quiz) {
    List<Widget> _children = [];
    for (int i = 0; i < 4; i++) {
      _children.add(CandWidget(
        index: i,
        text: quiz.candidates[i],
        width: width,
        answerState: _answerState[i],
        tap: () {
          setState(
            () {
              for (int j = 0; j < 4; j++) {
                if (j == 1) {
                  _answerState[j] = true;
                  _answers[_currentIndex] = j;
                } else {
                  _answerState[j] = false;
                }
              }
            },
          );
        },
      ));
      _children.add(
        Padding(
          padding: EdgeInsets.all(width * 0.024),
        ),
      );
    }
    return _children;
  }
}
