import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/screens/survey_screen/survey_info_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.asset(
              'assets/images/primarycolor_swatch.png',
              height: 400,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: 64,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                  )
                ],
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 25.0, top: 20, right: 20, bottom: 12),
          child: Text(
            'Create your account',
            style: TextStyle(fontSize: 20, fontFamily: 'Helvetica Neue'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: TextField(
            controller: emailController,
            style: const TextStyle(
              color: const Color.fromARGB(255, 100, 100, 100),
              fontSize: 15,
              fontFamily: 'Helvetica Neue',
            ),
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Color.fromARGB(255, 243, 220, 166),
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              contentPadding: const EdgeInsets.only(left: 25.0, right: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(70.0),
              ),
              hintText: 'Email',
              suffixIcon: const Icon(
                Icons.email,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: TextField(
            controller: passwordController,
            style: const TextStyle(
              color: Color.fromARGB(255, 100, 100, 100),
              fontSize: 15,
              fontFamily: 'Helvetica Neue',
            ),
            obscureText: true,
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Color.fromARGB(255, 243, 220, 166),
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              contentPadding: const EdgeInsets.only(left: 25.0, right: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(70.0),
              ),
              hintText: 'Password',
              suffixIcon: const Icon(
                Icons.lock,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              onPressed: () {
                String email = emailController.text;
                String password = passwordController.text;
                // Do something with the email and password, like sending them to a server for authentication
                // Navigate to the first survey screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        SurveyInfoScreen(email: email, password: password),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(350, 20),
                backgroundColor: AppColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(70.0),
                ),
                shadowColor: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 12.0),
              ),
              child: Text(
                'Next',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 15,
                      fontFamily: 'Helvetica Neue',
                    ),
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
        Column(
          children: [
            Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Helvetica Neue',
                    fontSize: 15,
                  ),
                  children: [
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "Sign In",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline),
                      // add underline to the text
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pop();
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
