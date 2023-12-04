import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tayt_app/src/screens/body_screen/components/form.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'dart:io';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          // decoration: BoxDecoration(
          //     color: Colors.teal,
          //     borderRadius: new BorderRadius.only(
          //       bottomLeft: const Radius.circular(40.0),
          //     )),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 10),
              child: Text(
                'Help us understand you better!\n\nEnter your measurements below, or upload \na picture of yourself in a tight fitting outfit.',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.black,
                    fontFamily: 'Helvetica Neue',
                    // letterSpacing: 0,
                    fontSize: 16,
                    height: 1.2
                    // letterSpacing: -0.1,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
                child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              child: MeasurementsForm(),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.only(
                  // topRight: const Radius.circular(40.0),
                  bottomLeft: const Radius.circular(40.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3d000000),
                    blurRadius: 10,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
            ))),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              'OR',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.black,
                    fontSize: 19,
                    fontFamily: 'Poppins',
                  ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 17.0, bottom: 30),
            child: ElevatedButton.icon(
              onPressed: () {
                _pickImageFromGallery();
                // Navigator.pushNamed(context, HomeScreen.routeName);
              },
              icon: FaIcon(
                FontAwesomeIcons.camera,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(70.0),
                ),
                shadowColor: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 15.0),
              ),
              label: Text(
                ' Upload a Picture',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 19,
                      fontFamily: 'Helvetica Neue',
                    ),
              ),
            ),
          ),
        ),
        _selectedImage == null
            ? Text('No image selected.')
            : Image.file(_selectedImage!),
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
