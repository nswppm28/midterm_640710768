// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

// TODO: ใส่รหัสนักศึกษาที่ค่าสตริงนี้
const studentId = '640710768';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentQuestionIndex = 0; // Index ของคำถามปัจจุบัน
  List<Map<String, dynamic>> questions = [
    {
      'question': 'The first space flight was a great ………… .',
      'options': ['achievable', 'achievement', 'achieve', 'account'],
      'correctAnswer': 'achievement',
    },
    {
      'question': 'Old stories tell about the ………… of famous heroes.',
      'options': ['explorer', 'exaction', 'exploits', 'exalted'],
      'correctAnswer': 'exploits',
    },
    {
      'question': 'The weather is ………… for swimming.',
      'options': ['cloudy', 'suitable', 'sunny', 'hot'],
      'correctAnswer': 'suitable',
    },
    {
      'question': 'The contestants ………… the judge’s decision.',
      'options': ['ran', 'disputed', 'discharged', 'disability'],
      'correctAnswer': 'disputed',
    },
  ];
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_colorful.jpg"),
              opacity: 0.6,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Good Morning',
                  textAlign: TextAlign.center, style: textTheme.headlineMedium),
              Text(studentId,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black87)),
              Spacer(),
              _buildQuizView(),
              Spacer(),
              _buildButtonPanel(),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  _buildQuizView() {
    if (currentQuestionIndex < questions.length) {
      final question = questions[currentQuestionIndex];
      final questionText = question['question'] as String;
      final options = question['options'] as List<String>;

      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(50.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 7,
              blurRadius: 12,
              offset: Offset(0, 10), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Question ${currentQuestionIndex + 1}',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 5.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(
                    color: Colors.black,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 7,
                      blurRadius: 12,
                      offset: Offset(0, 10), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    questionText,
                    style: TextStyle(fontSize: 20.0, color: Colors.white,),
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              ...options.map((option) => ElevatedButton(
                onPressed: () {
                  // Check if the selected option is correct
                  if (option == question['correctAnswer']) {
                    // Handle correct answer here
                  } else {
                    // Handle incorrect answer here
                  }
                  // Move to the next question
                  setState(() {
                    currentQuestionIndex++;
                  });
                },

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(option),
                    // แสดงไอคอนตรวจสอบถูกต้องหรือไอคอนปิดตามผลลัพธ์
                    if (option == question['correctAnswer'])
                      Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 32.0,
                      )
                    else
                      Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 32.0,
                      ),
                  ],
                ),
              )),
            ],
          ),
        ),
      );
    } else {
      // Show a message or screen when all questions are answered
      return Text(
        'Congratulations! You have completed the quiz.',
        style: TextStyle(fontSize: 20.0),
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _buildButtonPanel() {

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButton(
        onPressed: () {
          // ตรวจสอบว่ามีคำถามก่อนหน้าหรือไม่
          if (currentQuestionIndex > 0) {
            // ถ้ามีคำถามก่อนหน้า ให้ลดค่า currentQuestionIndex ด้วย 1
            setState(() {
              currentQuestionIndex--;
            });

            // แสดงโจทย์ใหม่
            var previousQuestion = questions[currentQuestionIndex];
            var previousQuestionText = previousQuestion['question'] as String;
            var previousOptions = previousQuestion['options'] as List<String>;

            // สามารถแสดงโจทย์และตัวเลือกในโจทย์ก่อนหน้าได้ที่นี่
            print('Previous Question: $previousQuestionText');
            print('Previous Options: $previousOptions');
          } else {
            // ถ้าไม่มีคำถามก่อนหน้า คุณสามารถแจ้งเตือนว่านี่คือคำถามแรกได้
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Information'),
                  content: Text('This is the first question.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Text(
          '<',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.pink.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          minimumSize: Size(50.0, 50.0),
        ),
      ),


      SizedBox(width: 16.0), // เพิ่มระยะห่างระหว่างปุ่ม
      ElevatedButton(
        onPressed: () {
          // ตรวจสอบว่ายังมีคำถามในรายการหรือไม่
          if (currentQuestionIndex < questions.length - 1) {
            // ถ้ายังมีคำถามให้เพิ่มค่า currentQuestionIndex ด้วย 1
            setState(() {
              currentQuestionIndex++;
            });
          } else {
            // ถ้าไม่มีคำถามอื่นแล้ว คุณสามารถแสดงข้อความ "คุณเสร็จสิ้นแล้ว" หรือสิ่งที่คุณต้องการทำในนี้
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Congratulations!'),
                  content: Text('You have completed the quiz.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Text(
          '>',
          style: TextStyle(
            color: Colors.black, // สีของตัวอักษร
            fontSize: 24.0, // ขนาดตัวอักษร
            fontWeight: FontWeight.bold, // น้ำหนักตัวอักษร
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.green.shade600, // สีพื้นหลังของปุ่ม
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // กำหนดรูปแบบของมุมของปุ่ม
          ),
          minimumSize: Size(50.0, 50.0),

        ),
      ),
    ]);
  }
}
