import 'package:flutter/material.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/screens/survey_screen/components/body.dart';
import 'package:tayt_app/src/widgets/nav_bar.dart';
import 'package:tayt_app/src/widgets/upload_picture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tayt_app/src/screens/survey_screen/final_screen.dart';
import 'dart:io';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({Key? key}) : super(key: key);

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  List<String> answers = List.filled(7, '');
  final List<String> questions = [
    'Are you male or female?',
    'What is your weight?',
    'What is your height?',
    'Would you rather upload your image or insert three more body measurements?',
    'What is the circumference of your chest?',
    'What is the circumference of your hips?',
    'What is the circumference of your waist?',
  ];

  // Variable to track the current question index
  int currentQuestionIndex = 0;
  String? _gender;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff233d4d), Color(0xff2B4B5F)],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        (currentQuestionIndex == 3 ? 0.53 : (currentQuestionIndex > 3 ? 0.32 : 
                        (currentQuestionIndex == 1 || currentQuestionIndex == 0 ? 0.323 : 0.3))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: (_currentPageIndex) / questions.length,
                                  backgroundColor: Colors.white,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                '${((_currentPageIndex) / questions.length * 100).toInt()}%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: questions.length,
                            itemBuilder: (context, index) {
                              // Set the current question index
                              currentQuestionIndex = index;
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              questions[index],
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[800],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            // Display different UI for the first question
                                            index == 0
                                                ? Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Radio<String>(
                                                            value: 'male',
                                                            groupValue: _gender,
                                                            onChanged: (String? value) {
                                                              setState(() {
                                                                _gender = value;
                                                                answers[index] = _gender!;
                                                              });
                                                            },
                                                          ),
                                                          Text(
                                                            'Male',
                                                            style: TextStyle(color: Colors.black),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Radio<String>(
                                                            value: 'female',
                                                            groupValue: _gender,
                                                            onChanged: (String? value) {
                                                              setState(() {
                                                                _gender = value;
                                                                answers[index] = _gender!;
                                                              });
                                                            },
                                                          ),
                                                          Text(
                                                            'Female',
                                                            style: TextStyle(color: Colors.black),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : index == 3
                                                    ? Column(
                                                        children: [
                                                          UploadPictureWidget(
                                                            onImageSelected: (File image) {
                                                              setState(() {
                                                                answers[index] = image.path;
                                                              });
                                                            },
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  // If an image is uploaded, go to the home screen
                                                                  Navigator.of(context).push(
                                                                    MaterialPageRoute(
                                                                      builder: (context) => Body(),
                                                                    ),
                                                                  );
                                                                },
                                                                child: Text(
                                                                  'Skip',
                                                                  style: TextStyle(color: Colors.white),
                                                                ),
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor: AppColors.primaryColor,
                                                                  elevation: 0,
                                                                  // Increase width
                                                                  minimumSize: Size(180, 40),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    : TextField(
                                                        onChanged: (value) {
                                                          setState(() {
                                                            answers[index] = value;
                                                          });
                                                        },
                                                        decoration: InputDecoration(
                                                          hintText: 'Enter your answer',
                                                          filled: true,
                                                          fillColor: Colors.grey[200],
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                            borderSide: BorderSide.none,
                                                          ),
                                                        ),
                                                      ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            onPageChanged: (index) {
                              setState(() {
                                _currentPageIndex = index;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the next page or complete the survey
                      if (_currentPageIndex < questions.length - 1 && answers[3] == '') {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FinalScreen(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(350, 40),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      backgroundColor: AppColors.secondaryColor.withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: Colors.black.withOpacity(0.5),
                    ),
                    child: Text(
                      _currentPageIndex < questions.length - 1 ? 'Next' : 'Complete',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
