import 'package:flutter/material.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/screens/survey_screen/components/body.dart';

class SurveyInfoScreen extends StatelessWidget {
  final String email;
  final String password;
  const SurveyInfoScreen(
      {Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(email: email, password: password),
    );
  }
}
