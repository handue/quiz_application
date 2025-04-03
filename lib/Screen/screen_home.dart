import 'package:flutter/material.dart';
import 'package:quiz_app_test/Screen/screen_quiz.dart';
import 'package:quiz_app_test/model/model_quiz.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // 기기 크기와 상관 없이 위젯 크기나 비율 일정하게 하려면 MediaQuery 써서 정보 가져옴
    Size screenSize = MediaQuery.of(context).size; // 현재 위젯의 화면 크기 가져오기
    double width = screenSize.width; // 현재 위젯 가로,세로가 위와 같음
    double height = screenSize.height;

    return SafeArea(
      // SafeArea는 기기의 상단 노티 바 부분, 하단 영역을 침범하지 않는 안전한 영역 잡아주는 것
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Quiz App',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: Colors.deepPurple,
          leading:
              Container(), // 앱 바에서 좌측에 있는 버튼을 지우는거, 페이지 이동시에 자동으로 생겨나는 뒤로 가기 버튼 등을 지울 수 있다네.
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                'images/quiz.jpeg',
                width: width * 0.8,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.03),
            ),
            Text(
              '플러터 퀴즈 앱',
              style: TextStyle(
                  fontSize: width * 0.08, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.01),
            ),
            const Text(
              '퀴즈를 풀기 전 안내사항입니다. \n 꼼꼼히 읽고 퀴즈 풀기를 눌러주세요.',
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.05),
            ),
            _buildStep(width, '1. 랜덤으로 나오는 퀴즈 3개를 풀어보세요.'),
            _buildStep(width, '2. 문제를 잘 읽고 정답을 고른 뒤 다음 문제 버튼을 눌러주세요.'),
            _buildStep(width, '3. 만점을 향해 도전해보세요!'),
            Padding(
              padding: EdgeInsets.all(width * 0.03),
            ),
            Container(
              padding: EdgeInsets.only(bottom: width * 0.036),
              child: Center(
                child: ButtonTheme(
                  minWidth: width * 0.8,
                  height: height * 0.05,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    width: width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(quizs: quizs),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: const Text(
                        '지금 퀴즈 풀기',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStep(double width, String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        width * 0.05,
        width * 0.01,
        width * 0.048,
        width * 0.01,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_box,
            size: width * 0.04,
          ),
          Padding(
            padding: EdgeInsets.only(
              right: width * 0.024,
            ),
          ),
          Flexible(
            child: Text(title),
          ),
        ],
      ),
    );
  }
}
