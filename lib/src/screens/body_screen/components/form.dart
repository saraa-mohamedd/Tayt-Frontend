import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/services.dart';
import 'package:tayt_app/src/deps/colors.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
        ],
        style: TextStyle(
          color: Color.fromARGB(255, 215, 182, 34),
          fontSize: 15,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0),
          filled: true,
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.white)),
          contentPadding: const EdgeInsets.only(left: 3.0, right: 20.0),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: Color.fromARGB(143, 228, 215, 185))),
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Color.fromARGB(255, 243, 220, 166),
              fontSize: 15,
              fontFamily: 'Helvetica Neue'),
          labelText: labelText,
          labelStyle: const TextStyle(
              color: Color.fromARGB(220, 255, 255, 255),
              fontSize: 15,
              fontFamily: 'Helvetica Neue',
              letterSpacing: -0.1),
        ),
      ),
    );
  }
}

class MeasurementsForm extends StatefulWidget {
  const MeasurementsForm({Key? key}) : super(key: key);

  @override
  State<MeasurementsForm> createState() => _MeasurementsFormState();
}

class _MeasurementsFormState extends State<MeasurementsForm> {
  _MeasurementsFormState({Key? key});

  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final hipsController = TextEditingController();
  final chestController = TextEditingController();
  final inseamController = TextEditingController();
  final thighController = TextEditingController();
  final waistController = TextEditingController();
  bool _isFemale = true;

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    hipsController.dispose();
    chestController.dispose();
    inseamController.dispose();
    thighController.dispose();
    waistController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              // border: Border.fromBorderSide(
              //   BorderSide(
              //     color: Color.fromARGB(255, 46, 17, 20),
              //     width: 3.0,
              //   ),
              // ),
              // color: Color(0xfa6c3e57),
              // boxShadow: [
              //   BoxShadow(
              //     color: Color(0x3d000000),
              //     blurRadius: 10,
              //     offset: Offset(5, 5),
              //   ),
              // ],
            ),
          ),
        ),
        Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: ToggleSwitch(
                minWidth: 170,
                cornerRadius: 70.0,
                activeBgColors: [
                  // const [Color.fromARGB(255, 144, 170, 159) Color(0xfff4d58d)],
                  // const [Color.fromARGB(255, 144, 170, 159) Color(0xfff4d58d)]
                  const [AppColors.secondaryColor],
                  const [AppColors.secondaryColor]
                ],
                inactiveBgColor: Colors.grey[400],
                initialLabelIndex: 0,
                borderColor: [
                  const Color.fromARGB(255, 192, 192, 192),
                  Color.fromARGB(255, 192, 192, 192)
                ],
                borderWidth: 1.0,
                totalSwitches: 2,
                animate: true,
                animationDuration: 100,
                labels: ['Female', 'Male'],
                radiusStyle: true,
                onToggle: (index) {
                  _isFemale = index == 0;
                  // print('switched to: $index');
                },
                // curve: Curves.linear,
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
            // child: GenderToggleSwitch(),
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
          MeasurementTextField(
            labelText: 'Hips',
            hintText: 'in cm',
            controller: hipsController,
          ),
          MeasurementTextField(
            labelText: 'Chest',
            hintText: 'in cm',
            controller: chestController,
          ),
          MeasurementTextField(
            labelText: 'Inseam',
            hintText: 'in cm',
            controller: inseamController,
          ),
          MeasurementTextField(
            labelText: 'Thigh',
            hintText: 'in cm',
            controller: thighController,
          ),
          MeasurementTextField(
              labelText: 'Waist',
              hintText: 'in cm',
              controller: waistController),
          Padding(
            padding: const EdgeInsets.only(
              top: 17.0,
            ),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: ((context) {
                      return AlertDialog(
                        title: const Text('Measurements Submitted'),
                        content: Text(heightController.text +
                            '\n' +
                            weightController.text +
                            '\n' +
                            hipsController.text +
                            '\n' +
                            chestController.text +
                            '\n' +
                            inseamController.text +
                            '\n' +
                            thighController.text +
                            '\n' +
                            _isFemale.toString()),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    }));
              },
              child: Text(
                'Submit',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black87,
                      fontSize: 15,
                      fontFamily: 'Helvetica Neue',
                    ),
              ),
              style: ElevatedButton.styleFrom(
                // backgroundColor: Color.fromARGB(255, 144, 170, 159),
                backgroundColor: AppColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(70.0),
                ),
                shadowColor: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 12.0),
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
