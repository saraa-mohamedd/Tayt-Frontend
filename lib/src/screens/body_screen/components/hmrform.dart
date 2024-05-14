import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tayt_app/provider/authentication_provider.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/screens/body_mesh_screen/body_mesh_screen.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tayt_app/provider/body_provider.dart';
import 'package:tayt_app/models/body_measurements.dart';

class MeasurementTextField extends StatelessWidget {
  const MeasurementTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  final String labelText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
        ],
        style: const TextStyle(
            color: Color.fromARGB(255, 238, 227, 180),
            fontSize: 18,
            fontFamily: 'Helvetica Neue'),
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0),
          filled: true,
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.white)),
          contentPadding: const EdgeInsets.only(left: 3.0, right: 20.0),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: Color.fromARGB(255, 153, 148, 117))),
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Color.fromARGB(255, 243, 220, 166),
              fontSize: 14,
              fontFamily: 'Helvetica Neue'),
          labelText: labelText,
          labelStyle: const TextStyle(
              color: Color.fromARGB(220, 255, 255, 255),
              fontSize: 17,
              fontFamily: 'Helvetica Neue',
              letterSpacing: -0.1),
        ),
      ),
    );
  }
}

class HMRForm extends StatefulWidget {
  const HMRForm({Key? key}) : super(key: key);

  @override
  State<HMRForm> createState() => _HMRFormState();
}

class _HMRFormState extends State<HMRForm> {
  _HMRFormState({Key? key});

  final heightController = TextEditingController();
  final weightController = TextEditingController();
  late File _selectedImage;
  bool isLoading = false;
  String gender = "female";

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final meshProvider = Provider.of<BodyProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final meshRenderer = Provider.of<BodyProvider>(context);
    final userId = authProvider.getUserId();

    return Stack(
      children: [
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
          ),
        ),
        Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: ToggleSwitch(
                minWidth: 170,
                cornerRadius: 70.0,
                activeBgColors: const [
                  [AppColors.secondaryColor],
                  [AppColors.secondaryColor]
                ],
                inactiveBgColor: Colors.grey[500],
                initialLabelIndex: 0,
                borderColor: [Colors.grey, Colors.grey],
                borderWidth: 1.0,
                totalSwitches: 2,
                animate: true,
                animationDuration: 100,
                labels: const ['Female', 'Male'],
                radiusStyle: true,
                onToggle: (index) {
                  gender = index == 0 ? "female" : "male";
                  print('switched to: $gender');
                },
                customTextStyles: const [
                  TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontFamily: 'Helvetica Neue',
                      letterSpacing: -0.1),
                  TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontFamily: 'Helvetica Neue',
                      letterSpacing: -0.1),
                ]),
          ),
          MeasurementTextField(
            labelText: 'Height',
            hintText: 'in cm',
            controller: heightController,
          ),
          MeasurementTextField(
            labelText: 'Weight',
            hintText: 'in kg',
            controller: weightController,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 17.0, bottom: 10),
              child: ElevatedButton.icon(
                onPressed: () async {
                  try {
                    await _pickImageFromGallery();
                  } catch (error) {
                    // Handle error if any
                    print("Error: $error");
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                icon: Icon(
                  Icons.camera,
                  color: AppColors.primaryColor,
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70.0),
                  ),
                  shadowColor: Colors.black.withOpacity(0.5),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10.0),
                ),
                label: Text(
                  ' Upload a Picture',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 15,
                        fontFamily: 'Helvetica Neue',
                      ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: ElevatedButton(
              onPressed: () async {
                if (heightController.text.isEmpty ||
                    weightController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.secondaryColor,
                      content: Text(
                        'Please fill all fields',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  );
                  return;
                }

                setState(() {
                  isLoading = true;
                });
                meshProvider.editBodyMesh(
                    userId,
                    double.parse(heightController.text),
                    double.parse(weightController.text),
                    gender);
                await meshProvider
                    .generateBodyMeshUsingHMR(userId, _selectedImage)
                    .then((value) {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: BodyMeshScreen(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                  setState(() {
                    isLoading = false;
                  });
                });
                heightController.clear();
                weightController.clear();
              },
              child: Text(
                'Submit',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'Helvetica Neue',
                    ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(70.0),
                ),
                //shadowColor: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(
                    horizontal: 75.0, vertical: 10.0),
              ),
            ),
          ),
        ]),
        if (isLoading)
          // create small container with message and loading spinner
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width * 0.80,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor.withOpacity(0.9),
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x3d000000),
                    blurRadius: 10,
                    offset: const Offset(5, 5),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Generating Body Mesh...',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 20),
                    CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }
}
